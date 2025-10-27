# **TASK-4: Infrastructure as Code (IaC) with Terraform**

## **Overview**
This project demonstrates the automation of provisioning a Docker container on an AWS EC2 instance using **Terraform**.  
The setup uses **shell scripts** to install Docker and Terraform, enabling a fully automated and repeatable infrastructure deployment process.

---

## **Objective**
To provision a Docker container on an EC2 instance using Terraform by automating:
- Installation of Docker and Terraform.
- Infrastructure creation via Terraform.
- Container deployment and management through Terraform’s Docker provider.

---

## **Tools Used**
- **Terraform** – Infrastructure as Code (IaC) tool to provision EC2 and Docker resources.  
- **AWS EC2** – Cloud server used to host Docker.  
- **Docker** – Containerization tool used for deploying applications.  
- **Bash** – Automation through shell scripts (`docker.sh`, `terraform.sh`).  

---

## **Deliverables**
- `main.tf` – Defines Docker and EC2 resources.  
- `provider.tf` – Configures AWS and Docker providers.  
- `docker.sh` – Script to install and configure Docker on EC2.  
- `terraform.sh` – Script to install Terraform automatically.  
- **Execution Logs** – Logs generated from Terraform operations (`init`, `plan`, `apply`, `destroy`).  

---

## **Implementation Steps**

### **1. AWS EC2 Setup**
- An **AWS EC2 (t3.micro)** instance was created.  
- Security Group rules configured to allow:
  - **Port 22** – SSH access.
  - **Port 3000** – Application access.
- SSH was used to connect to the instance for installation and verification.

---

### **2. Docker Installation (`docker.sh`)**
A shell script named `docker.sh` automates the Docker installation process.

The script performs:
- Installation of Docker and dependencies using `dnf`.  
- Enabling and starting the Docker service.  
- Adding `ec2-user` to the Docker group for proper permissions. 

---

## 3. Terraform Installation (`terraform.sh`)

A shell script named **`terraform.sh`** was created to automate the installation of Terraform on the EC2 instance.

### Script Tasks
- **Downloads** the latest Terraform binary from the official HashiCorp repository.  
- **Extracts and moves** the Terraform binary to `/usr/local/bin` for system-wide access.  
- **Verifies the installation** using `terraform -v` to ensure Terraform is correctly installed and executable.  

---

## 4. Terraform Provider Configuration

Terraform was configured to manage both **AWS** and **Docker** resources:

### Providers
- **AWS Provider** – Creates and manages the EC2 instance that hosts Docker.  
- **Docker Provider** – Interacts with the Docker daemon running on the EC2 instance.  

### Backend Configuration
- Implemented **remote state management** using **S3** for state storage and **DynamoDB** for state locking.  
- **Deprecated backend fields** were replaced with `use_lockfile` for compatibility with newer Terraform versions.  

---

## 5. Resource Definition

Terraform configurations were defined to automate infrastructure creation:

- **AWS EC2 Instance** – Hosts Docker and Terraform for container deployment.  
- **Docker Image** – Pulled directly from Docker Hub (e.g., `nginx` or `hello-world`).  
- **Docker Container** – Automatically created, managed, and destroyed through Terraform commands.  

This ensures that all infrastructure components are **defined and maintained as code** for consistency and reproducibility.

---

## 6. Execution Workflow

The entire Terraform workflow was followed step-by-step to manage the lifecycle of the infrastructure:

Initialize:
terraform init – Initializes the working directory and downloads required providers.

Plan:
terraform plan – Previews the resources to be created and ensures configurations are correct.

Apply:
terraform apply – Executes the plan to provision EC2 and deploy Docker containers.

State Check:
terraform state list – Lists the current managed resources for verification.

Destroy:
terraform destroy – Removes all created infrastructure once testing is completed.

## 7. Backend Configuration and Issues

During setup, a few configuration issues were encountered and resolved:

AWS Credentials Error:
Fixed by properly configuring AWS CLI credentials and IAM roles with the required permissions.

Signature Mismatch Error:
Resolved by updating region and access settings in the provider block.

Deprecated Backend Fields:
Adjusted to newer Terraform syntax for backend configuration and state locking.

These fixes ensured smooth Terraform execution and stable backend management.

## 8. Verification

The final verification confirmed successful setup and operation of the infrastructure:

Docker installation validated using docker run hello-world.

Terraform commands (init, plan, apply, destroy) executed successfully without errors.

Docker containers were provisioned, managed, and destroyed using Terraform seamlessly.

Post-testing cleanup verified with terraform destroy, ensuring no residual resources remained.
