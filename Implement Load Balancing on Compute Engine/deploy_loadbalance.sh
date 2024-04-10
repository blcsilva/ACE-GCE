#!/bin/bash

# Extracting the region from the zone variable
export REGION="${ZONE%-*}"

# Creating a Virtual Private Cloud (VPC) named nucleus-vpc with automatic subnet mode
gcloud compute networks create nucleus-vpc --subnet-mode=auto

# Creating a virtual machine instance with specified configurations
gcloud compute instances create $INSTANCE_NAME \
          --network nucleus-vpc \
          --zone $ZONE  \
          --machine-type e2-micro  \
          --image-family debian-10  \
          --image-project debian-cloud 

# Creating a Kubernetes Engine cluster named nucleus-backend with a single node
gcloud container clusters create nucleus-backend \
--num-nodes 1 \
--network nucleus-vpc \
--zone $ZONE

# Getting credentials for the created Kubernetes cluster
gcloud container clusters get-credentials nucleus-backend \
--zone $ZONE

# Creating a Kubernetes deployment named hello-server using a specified image
kubectl create deployment hello-server \
--image=gcr.io/google-samples/hello-app:2.0

# Exposing the Kubernetes deployment hello-server as a LoadBalancer service on a specified port
kubectl expose deployment hello-server \
--type=LoadBalancer \
--port $PORT

# Creating a startup script for instances to execute initialization tasks
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

# Creating an instance template for VM instances with a startup script
gcloud compute instance-templates create web-server-template \
--metadata-from-file startup-script=startup.sh \
--network nucleus-vpc \
--machine-type g1-small \
--region $ZONE

# Creating a target pool for load balancing instances
gcloud compute target-pools create nginx-pool --region=$REGION

# Creating a managed instance group named web-server-group
gcloud compute instance-groups managed create web-server-group \
--base-instance-name web-server \
--size 2 \
--template web-server-template \
--region $REGION

# Creating a firewall rule to allow traffic on port 80 within the nucleus-vpc network
gcloud compute firewall-rules create $FIREWALL_NAME \
--allow tcp:80 \
--network nucleus-vpc

# Creating an HTTP health check for the load balancer
gcloud compute http-health-checks create http-basic-check
gcloud compute instance-groups managed \
set-named-ports web-server-group \
--named-ports http:80 \
--region $REGION

# Creating a backend service for the load balancer
gcloud compute backend-services create web-server-backend \
--protocol HTTP \
--http-health-checks http-basic-check \
--global

# Adding the managed instance group as a backend to the backend service
gcloud compute backend-services add-backend web-server-backend \
--instance-group web-server-group \
--instance-group-region $REGION \
--global

# Creating a URL map to route requests to the backend service
gcloud compute url-maps create web-server-map \
--default-service web-server-backend

# Creating a target HTTP proxy for the load balancer
gcloud compute target-http-proxies create http-lb-proxy \
--url-map web-server-map

# Creating a forwarding rule to forward traffic to the target HTTP proxy
gcloud compute forwarding-rules create http-content-rule \
--global \
--target-http-proxy http-lb-proxy \
--ports 80

# Listing the created forwarding rules
gcloud compute forwarding-rules list
