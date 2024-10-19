# Task 3. Deploying a K3s Cluster on AWS Using Terraform


## Overview
This project deploys a K3s Kubernetes cluster on AWS using Terraform. The infrastructure includes a VPC, public and private subnets, security groups, a Bastion host, and a K3s master node, all hosted in the `eu-central-1` region.

## Prerequisites

- **AWS CLI** installed and configured with appropriate IAM permissions.
- **Terraform** installed.
- **SSH Key Pair** created and imported into AWS.

## Setup and Deployment

### 1. Create an SSH Key Pair

If you don't already have an SSH key pair, create one locally:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/id_aws_rsa
```

Then, import the public key into AWS:

```bash
aws ec2 import-key-pair --key-name "aws_devops_key" --public-key-material fileb://~/.ssh/id_aws_rsa.pub
```

Make sure to replace `aws_devops_key` with your preferred key name.

### 2. Clone the Repository

Clone this repository or create the necessary files as outlined in this guide.

### 3. Configure Terraform Variables

Edit the `terraform.tfvars` file and provide the required values, including your AWS key pair name (`key_name`), region, and subnet configurations.

### 4. Initialize Terraform

Run the following command to initialize Terraform and download the necessary providers:

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
- Navigate to the `phase2/` directory:

  ```bash
  cd terraform/phase2/
  ```

- Reconfigure Terraform to use the remote backend by running:

  ```bash
  terraform init -reconfigure
  ```

  This command reconfigures the backend to use the S3 bucket created in Phase 1 for storing the Terraform state remotely.

### 5. Plan and Apply the Terraform Code

Run the following commands to create a plan and apply the configuration to AWS:

```bash
terraform plan
terraform apply
```

When prompted, confirm by typing `yes`.

### 6. Check connection to the Bastion Host

Once the infrastructure is created, connect to the Bastion Host via SSH using the public IP provided in the output:

```bash
ssh -i ~/.ssh/id_aws_rsa ubuntu@$(terraform output -raw bastion_host_public_ip)
```

- Install the kubectl binary localy:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

Make the binary executable:
```bash
chmod +x ./kubectl
```

Move the binary to your system’s PATH:
```bash
sudo mv ./kubectl /usr/local/bin/kubectl
```

Verify the installation:
```bash
kubectl version --client
```
SSH into the K3s Master Node from the Bastion Host (replace <K3S_MASTER_PRIVATE_IP>):
```bash
ssh ubuntu@<K3S_MASTER_PRIVATE_IP>
```
Copy the K3s Configuration File to the Bastion Host:
```bash
scp /etc/rancher/k3s/k3s.yaml ubuntu@<Bastion_Public_IP>:~/k3s.yaml
```

Download the K3s Configuration File to Your Local Machine (from your local terminal):
```bash
scp -i ~/.ssh/id_aws_rsa ubuntu@<Bastion_Public_IP>:~/k3s.yaml ~/kubeconfig_k3s.yaml
```

Edit the Kubeconfig File if required:
Change the server: line in kubeconfig_k3s.yaml to point to localhost:
```yaml
server: https://localhost:6443
```
Set the KUBECONFIG Environment Variable:
```bash
export KUBECONFIG=~/kubeconfig_k3s.yaml
```

### 7. Set Up an SSH Tunnel for Accessing the K3s Cluster

Create an SSH tunnel from your local machine to access the K3s API server through the Bastion Host:

```bash
ssh -i ~/.ssh/id_aws_rsa -L 6443:$(terraform output -raw k3s_master_private_ip):6443 ubuntu@$(terraform output -raw bastion_host_public_ip) -N
```
- After you run this command, you should not be logged into the Bastion Host. Instead, the terminal will just sit there silently (because of the -N flag), keeping the SSH tunnel open.
- While this SSH session is open, in a separate terminal, you can run kubectl commands on your local machine (which will use the tunnel to communicate with the K3s API server).

### 8. Configure `kubectl` to Connect to the K3s Cluster

Configure `kubectl` on your local machine to access the K3s cluster:

```bash
kubectl config set-cluster k3s-cluster --server=https://localhost:6443 --insecure-skip-tls-verify=true
kubectl config set-context k3s-context --cluster=k3s-cluster
kubectl config use-context k3s-context
```

### 9. Deploy a Simple Application

Once `kubectl` is configured, deploy a simple application using a Kubernetes manifest:

```bash
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
```

### 10. Verify the Pod is Running

Check that the pod is successfully running:

```bash
kubectl get pods
```

### 11. Cleanup

When you're finished, you can destroy all the resources using the following command:

```bash
terraform destroy
```

Confirm the destruction by typing `yes` when prompted.

## Outputs

The following outputs will be provided after the Terraform deployment:

- **Bastion Host Public IP**: The public IP address of the Bastion Host.
- **K3s Master Node Private IP**: The private IP address of the K3s master node.

## Notes

- Ensure your AWS credentials are properly configured before running Terraform commands.
- The default region is `eu-central-1`, but you can change this in the `terraform.tfvars` file.
- The Bastion Host is necessary to securely access the K3s cluster in a private subnet.
