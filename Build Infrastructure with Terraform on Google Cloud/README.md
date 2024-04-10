# Build Infrastructure with Terraform on Google Cloud: Challenge Lab

This repository contains the solution for the challenge lab "Build Infrastructure with Terraform on Google Cloud". Below are the details of the tasks completed.

## Topics tested:

- Import existing infrastructure into your Terraform configuration.
- Build and reference your own Terraform modules.
- Add a remote backend to your configuration.
- Use and implement a module from the Terraform Registry.
- Re-provision, destroy, and update infrastructure.
- Test connectivity between the resources you've created.

## Pre-task:

Before starting the tasks, ensure you have edited and executed the `profile_export.sh` script to set up your environment properly.

## Task 1: Create the configuration files

The configuration files required for this task are structured as follows:

```
main.tf
variables.tf
modules/
├── instances
│   ├── instances.tf
│   ├── outputs.tf
│   └── variables.tf
└── storage
    ├── storage.tf
    ├── outputs.tf
    └── variables.tf
```

- `main.tf`: Main configuration file.
- `variables.tf`: File containing input variables.
- `modules/instances/`: Module directory for instances.
    - `instances.tf`: Configuration for instances module.
    - `variables.tf`: Input variables for instances module.
    - `outputs.tf`: Output variables for instances module.
- `modules/storage/`: Module directory for storage.
    - `storage.tf`: Configuration for storage module.
    - `variables.tf`: Input variables for storage module.
    - `outputs.tf`: Output variables for storage module.

These files and directories are structured as per the lab requirements and contain the necessary Terraform configurations for building infrastructure on Google Cloud.

Feel free to explore the contents of each file for more details.
