cd modules/instances/

cat > instances.tf <<EOF
# Resource configuration for instances (updated)
EOF

cd ~

cat > main.tf <<EOF
terraform {
  backend "gcs" {
    # Configuration for remote backend
  }
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

module "instances" {
  source     = "./modules/instances"
}

module "storage" {
  source     = "./modules/storage"
}

module "vpc" {
    # Configuration for VPC and subnets
}
EOF
terraform init
terraform apply --auto-approve
