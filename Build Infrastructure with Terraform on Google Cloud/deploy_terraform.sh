#This is a full script to execute the lab!
# Create variables.tf file with default values for region, zone, and project_id
variable "region" {
 default = "$REGION"
}

variable "zone" {
 default = "$ZONE"
}

variable "project_id" {
 default = "$PROJECT_ID"
}

# Create main.tf file with Terraform block and Google Provider
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# Initialize Terraform
terraform init

# Create instances.tf file inside the instances module
resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "n1-standard-1"
  zone         = "$ZONE"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "n1-standard-1"
  zone         = "$ZONE"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

# Change directory back to root
cd ~

# Import existing instances into Terraform
terraform import module.instances.google_compute_instance.tf-instance-1 $INSTANCE_ID_1
terraform import module.instances.google_compute_instance.tf-instance-2 $INSTANCE_ID_2

# Plan and apply the Terraform changes
terraform plan
terraform apply --auto-approve

# Create a Cloud Storage bucket resource inside the storage module
resource "google_storage_bucket" "storage-bucket" {
  name          = "$BUCKET_NAME"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}

# Change directory back to root
cd ~

# Configure storage module in main.tf
terraform {
  backend "gcs" {
    bucket  = "$BUCKET_NAME"
    prefix  = "terraform/state"
  }
}

# Initialize Terraform with GCS backend
echo "yes" | terraform init

# Modify instances.tf to update machine types and add a third instance

# Change directory to instances module
cd modules/instances/

# Modify instances.tf to update machine types and add a third instance

# Change directory back to root
cd ~

# Initialize Terraform and apply changes
terraform init
terraform apply --auto-approve

# Use a module from the Terraform Registry

# Add VPC module configuration to main.tf
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0.0"

  project_id   = "$PROJECT_ID"
  network_name = "$VPC_NAME"
  routing_mode = "GLOBAL"

  subnets = [
      {
          subnet_name           = "subnet-01"
          subnet_ip             = "10.10.10.0/24"
          subnet_region         = "$REGION"
      },
      {
          subnet_name           = "subnet-02"
          subnet_ip             = "10.10.20.0/24"
          subnet_region         = "$REGION"
          subnet_private_access = "true"
          subnet_flow_logs      = "true"
          description           = "Please like share & subscribe to quicklab"
      },
  ]
}

# Change directory to instances module
cd modules/instances/

# Update instances.tf to connect instances to subnets

# Change directory back to root
cd ~

# Initialize Terraform and apply changes
terraform init
terraform apply --auto-approve

# Configure a firewall

# Add Google Compute Firewall resource to main.tf

# Initialize Terraform and apply changes
terraform init
terraform apply --auto-approve
