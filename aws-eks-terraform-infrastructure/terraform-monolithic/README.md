This `README.md` is structured to provide a professional overview of your **subbu-cluster** 3-tier architecture. It outlines the infrastructure components, security posture, and the CI/CD readiness of the environment.

---

# AWS EKS 3-Tier Infrastructure with Terraform

This repository contains the Terraform configuration for a production-ready, highly available AWS environment. It deploys a custom VPC, a managed Amazon EKS cluster using Spot instances for cost optimization, and dedicated management instances for Ansible and Jenkins.

## 🏗 Infrastructure Overview

### 1. Networking (VPC)

The foundation consists of a custom VPC designed with a "Public-Private" isolation strategy across three Availability Zones (AZs) for high availability.

* **Gateways**: 1 Internet Gateway (IGW) for public access and 1 NAT Gateway (with Elastic IP) to allow private resources to securely reach the internet.
* **Subnets**:
* **3 Public Subnets**: Used for the IGW, NAT Gateway, and management instances.
* **3 Private Subnets**: Dedicated to EKS Worker Nodes to ensure zero direct exposure to the internet.


* **Routing**:
* **Public Route Table**: Routes traffic to the Internet Gateway.
* **Private Route Table**: Routes internal traffic to the NAT Gateway.
* **Associations**: All 6 subnets are explicitly associated with their respective route tables.



### 2. Security Configuration (SG)

A centralized Security Group acts as a multi-layer firewall:

* **Inbound Rules**:
* `22 (SSH)`: Restricted for administrative management.
* `80 (HTTP)`: Standard web traffic.
* `8080 (Jenkins)`: CI/CD server access.
* `9000 (SonarQube)`: Code quality analysis.
* `443 (HTTPS)`: Secure communication from the EKS Jump Server.


* **Outbound Rules**:
* `0.0.0.0/0`: Allows all egress traffic for updates and external API calls.



### 3. Management Instances (EC2)

Two dedicated t3.large instances are deployed into the public subnets to handle automation and deployment:

* **Ansible Node**: Orchestration and configuration management.
* **Jenkins Node**: CI/CD pipeline execution for application deployment.

### 4. Kubernetes Cluster (Amazon EKS)

A managed EKS cluster (v1.35) serves as the orchestration layer for the microservices.

* **Cluster Configuration**:
* **Network**: Attached to all 6 subnets (Public/Private) for balanced control plane communication.
* **Auth**: Modern API-based authentication mode.


* **Worker Nodes (Data Plane)**:
* **Capacity**: Optimized using **SPOT** instances (`t3.medium`) to reduce student lab costs by up to 70%.
* **Placement**: Isolated within the 3 Private Subnets.
* **Scaling**: Configurable Auto Scaling Group (1 Min, 2 Desired, 3 Max).


* **Add-ons & Security**:
* **Standard Add-ons**: `vpc-cni`, `coredns`, and `kube-proxy`.
* **OIDC Provider**: Configured with TLS certificates to enable IAM Roles for Service Accounts (IRSA), allowing pods to securely access AWS services.



### 5. State Management & Backend

To ensure team collaboration and state persistence, the project uses a remote backend:

* **S3 Bucket**: Dedicated bucket for `terraform.tfstate` storage with versioning enabled for disaster recovery.
* **Backend Block**: Configured in `providers.tf` to point to the S3 bucket with encryption enabled.

---

## 📊 Deployment Outputs

Upon successful deployment, Terraform provides the following critical connection data:

1. **Cluster Endpoint**: The URL for the Kubernetes API server.
2. **Cluster Name**: Unique identifier for the EKS cluster.
3. **AWS Region**: The deployment location (e.g., `us-east-1`).
4. **CA Data**: Certification authority data required for secure `kubectl` communication.
5. **OIDC Issuer URL**: The identity bridge URL for IRSA configuration.

---

## 🚀 How to Deploy

1. **Initialize**: `terraform init` (Downloads providers and sets up the S3 backend).
2. **Validate**: `terraform validate` (Checks for syntax errors).
3. **Plan**: `terraform plan` (Reviews infrastructure changes).
4. **Apply**: `terraform apply -auto-approve` (Provision the infrastructure).

1.  **Initialize**: 
    ```bash
    terraform init
    ```
2.  **Plan**: 
    ```bash
    terraform plan
    ```
3.  **Apply**: 
    ```bash
    terraform apply -auto-approve
    ```
4. **Get EKS Cluster Details**:
    ```bash
    terraform output cluster_name
    terraform output endpoint
    ```
5. **Get Public IPs for your EC2 instances**:
    ```bash
    terraform output public_1_ip
    terraform output public_2_ip
    ```

---

## 🔐 Post-Deployment: Connect to Cluster

To connect your local `kubectl` to the new cluster, run:

```bash
aws eks update-kubeconfig --region us-east-1 --name subbu-cluster
```

---

*Note: This architecture is designed for a DevOps fresher portfolio, demonstrating expertise in Cloud Networking, Managed Kubernetes, and Infrastructure as Code (IaC).*

