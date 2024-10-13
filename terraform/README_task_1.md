# [Task 1: AWS Account Configuration](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/1_basic-configuration/task_1.md)


This repository demonstrates how to use **Terraform** to:
- Create an S3 bucket for storing Terraform state.
- Transition from a **local backend** to a **remote backend** using the S3 bucket for Terraform state management.

### Key Features:
1. **Phase 1**: Terraform creates the S3 bucket using a local backend.
2. **Phase 2**: Once the S3 bucket is created, Terraform switches to the remote backend using the same S3 bucket to manage the state remotely.

The workflow ensures a smooth process by creating the bucket first and transitioning to the remote backend only after the bucket is available. This allows for a clean and efficient Terraform workflow.

---

## Pre-requisites

Before starting, make sure you have the following tools installed:

1. **Terraform** (Version 1.9.7): Required for managing AWS resources.
2. **AWS CLI**: Ensure that you have configured AWS CLI with your AWS credentials and set the appropriate region.
3. **Git**: Version control is managed with Git. Make sure the repository is cloned locally.

---

## Variables

There are several variables available in the Terraform configurations. These variables allow for flexibility in defining the AWS region, bucket name, and environment.

### Available Variables:

| Variable Name    | Description                                                    | Default Value             |
|------------------|----------------------------------------------------------------|---------------------------|
| `aws_region`     | AWS region where the resources will be created.                | `eu-central-1`            |
| `bucket_name`    | Name of the S3 bucket used to store the Terraform state.       | `nicko-terraform-state-bucket` |
| `environment`    | Environment name tag (e.g., Dev, Prod)                         | `Dev`                     |

You can override these values either by creating a `terraform.tfvars` file or directly via the command line.

---

## Steps

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone <repo-url>
cd <repo-directory>
```

This will clone the repository and allow you to work with the provided configurations.

---

### 2. Step 1: Create the S3 Bucket with Local Backend

In this phase, Terraform is configured to use a **local backend** to create the S3 bucket for storing the Terraform state.

#### Steps:
- Navigate to the `phase1/` directory:

  ```bash
  cd terraform/phase1/
  ```

- Initialize Terraform:

  ```bash
  terraform init
  ```

- Apply the configuration to create the S3 bucket:

  ```bash
  terraform apply -auto-approve
  ```

  This will:
  - Initialize Terraform with a local backend.
  - Create the S3 bucket in AWS.
  - Apply other resources such as versioning, encryption, and public access settings for the S3 bucket.

**Note**: You can check the AWS console to confirm the S3 bucket (`nicko-terraform-state-bucket`) is created.

---

### 3. Step 2: Switch to Remote Backend

After the S3 bucket has been created in Phase 1, you will now transition to using the remote backend for storing the Terraform state.

#### Steps:
- Navigate to the `phase2/` directory:

  ```bash
  cd terraform/phase2/
  ```

- Reconfigure Terraform to use the remote backend by running:

  ```bash
  terraform init -reconfigure
  ```

  This command reconfigures the backend to use the S3 bucket created in Phase 1 for storing the Terraform state remotely.

- After that, apply the configuration to continue managing resources using the remote backend:

  ```bash
  terraform plan -var-file="terraform.tfvars"
  terraform apply -var-file="terraform.tfvars" -auto-approve
  ```

This will:
- Switch the backend to the S3 bucket for storing the state remotely.
- Apply any necessary configurations related to the remote backend.

---


## Troubleshooting

If you encounter any issues during the setup, make sure to:
1. Ensure that the S3 bucket (`nicko-terraform-state-bucket`) exists in the AWS region specified.
2. Confirm your AWS credentials are configured correctly with the AWS CLI.
3. If any Terraform commands fail, run `terraform plan` first to check for issues in your configurations.
