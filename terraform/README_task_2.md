# [Task 2: AWS Account Configuration](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/1_basic-configuration/task_2.md)


#### Steps:
- Navigate to the `phase1/` directory:

  ```bash
  cd phase1/
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
  cd ../phase2/
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