terraform taint module.instances.google_compute_instance.$INSTANCE_NAME
terraform plan
terraform apply --auto-approve
