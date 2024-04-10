Build Infrastructure with Terraform on Google Cloud: Challenge Lab

Topics tested:
Import existing infrastructure into your Terraform configuration.
Build and reference your own Terraform modules.
Add a remote backend to your configuration.
Use and implement a module from the Terraform Registry.
Re-provision, destroy, and update infrastructure.
Test connectivity between the resources you've created.

Pre-task:
Edit and execute:
profile_export.sh

Task 1. Create the configuration files

main.tf
variables.tf
modules/
└── instances
    ├── instances.tf
    ├── outputs.tf
    └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf
