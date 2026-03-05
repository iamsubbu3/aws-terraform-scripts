# AWS EKS Production-Style Infrastructure (Terraform)

![Terraform](https://img.shields.io/badge/IaC-Terraform-blue)
![AWS](https://img.shields.io/badge/Cloud-AWS-orange)
![Kubernetes](https://img.shields.io/badge/Orchestration-EKS-blue)
![CI/CD](https://img.shields.io/badge/CI/CD-Jenkins-red)
![License](https://img.shields.io/badge/License-MIT-green)

This repository provisions a production-style, highly available AWS
environment using modular Terraform. It includes a custom VPC, Amazon
EKS with SPOT worker nodes, and management instances for Ansible and
Jenkins.

------------------------------------------------------------------------

## Why This Architecture?

-   Multi-AZ high availability (3 public + 3 private subnets)
-   Private EKS worker node isolation
-   Cost optimization using SPOT capacity
-   Modular, reusable Terraform design
-   Secure access with least-exposure security groups

------------------------------------------------------------------------

## Project Architecture (Modules)

-   **VPC Module**
    -   Creates VPC, IGW, 3 Public + 3 Private Subnets, NAT Gateway,
        routing
    -   Subnets tagged for Kubernetes load balancers
-   **Security Module**
    -   Centralized security group
    -   SSH restricted to admin IP
    -   Intra-SG SSH for Ansible → Jenkins
    -   HTTP/HTTPS/Jenkins/SonarQube access
-   **Compute Module**
    -   Deploys configurable EC2 instances using `for_each`
    -   Used as Ansible Control Node and Jenkins CI/CD Server
    -   Instances distributed across AZs
-   **EKS Module**
    -   Managed control plane (v1.31)
    -   Node group in private subnets
    -   SPOT instances with multiple instance types
    -   Launch Template for disk and naming

------------------------------------------------------------------------

## Infrastructure Overview

### Networking (VPC)

-   3 Public Subnets (IGW, NAT, Management EC2)
-   3 Private Subnets (EKS Worker Nodes)

**Gateways** - Internet Gateway (public access) - Single NAT Gateway
(cost‑effective for labs; production typically uses one per AZ)

**Routing** - Public → IGW - Private → NAT

------------------------------------------------------------------------

## Security Configuration

**Inbound** - 22 (SSH) -- Admin IP + intra-SG access - 443 (HTTPS) --
EKS API access - 80--9000 -- Web/Jenkins/SonarQube

**Outbound** - Allow all egress

------------------------------------------------------------------------

## Management Instances

-   **Ansible Control Node** -- configuration management
-   **Jenkins Server** -- CI/CD pipelines

------------------------------------------------------------------------

## Kubernetes (Amazon EKS)

-   Control plane attached to public + private subnets
-   Worker nodes in private subnets
-   SPOT capacity with multiple instance types
-   Scaling: min 1, desired 2, max 3
-   Add-ons: VPC CNI, CoreDNS, kube-proxy
-   OIDC enabled for IRSA

------------------------------------------------------------------------

## Tools & Technologies

-   AWS VPC
-   Amazon EKS
-   Terraform (Modular)
-   Jenkins
-   Ansible
-   Kubernetes
-   GitHub

------------------------------------------------------------------------

## Skills Demonstrated

-   Infrastructure as Code (Terraform)
-   Multi-AZ Network Design
-   Kubernetes Provisioning (EKS)
-   Security Group Hardening
-   CI/CD Readiness
-   Cost Optimization with SPOT

------------------------------------------------------------------------

## Repository Structure

    .
    ├── main.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── providers.tf
    ├── s3.tf
    ├── backend.tf
    └── modules/
        ├── vpc/
        ├── security/
        ├── compute/
        └── eks/

------------------------------------------------------------------------

## Deployment

``` bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

------------------------------------------------------------------------

## Post‑Deployment

Configure kubectl:

``` bash
aws eks update-kubeconfig --region us-east-1 --name subbu-cluster
```

View outputs:

``` bash
terraform output cluster_name
terraform output endpoint
terraform output public_ips
```


------------------------------------------------------------------------

## Portfolio Objective

Demonstrates end‑to‑end DevOps skills across cloud networking, managed
Kubernetes, automation, and secure infrastructure design.
