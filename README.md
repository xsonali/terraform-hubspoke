Terraform Hub-Spoke Architecture on Azure
=========================================

This project provisions a Hub-and-Spoke network topology on Microsoft Azure using Terraform, deployed via Azure DevOps pipelines. It is production-quality and designed for work reference, learning, experimentation, and demonstrating Infrastructure as Code (IaC) with remote backend state management and CI/CD automation.

Project Structure
--------------------
terraform-hubspoke/
├── main.tf # Provider and resource group
├── variables.tf # Input variables
├── outputs.tf # Output values
├── backend.tf # Remote backend configuration
├── vm.tf # Linux/Windows VM configuration
├── nsg.tf # Network Security Groups
├── dns.tf # Private and public DNS zones with A records configured for internal and external name resolution.
├── route_table.tf # Custom route tables
├── monitor.tf # Monitoring and diagnostics
├── vpn.tf # VPN Gateway setup
├── firewall.tf # Azure Firewall deployment with network and application rules configured for traffic filtering and security control.
├── cloud-init-dns.yaml # Cloud-init configuration for DNS VM and Apache2
├── azure-pipelines.yml # Azure DevOps CI/CD pipeline definition
├── .gitignore # Git ignored files
└── README.md # Project documentation

Features
-----------
• Hub-and-Spoke network architecture with centralized routing, traffic and private DNS management, and enhanced security posture
• NSG and Firewall rules for traffic control
• Automated Linux/Windows VM deployment (with cloud-init)
• Azure DNS zone and A record creation
• Remote state management using Azure Blob Storage
• CI/CD pipeline using Azure DevOps

Getting Started
------------------
✅ Prerequisites
• Azure Subscription
• Terraform CLI installed
• Azure DevOps Project
• Service Connection (SP with Contributor or Owner access)
• Azure Storage Account for remote backend

Deployment Steps
-------------------
1. Clone the Repository
   git clone https://github.com/your-username/terraform-hubspoke.git
   cd terraform-hubspoke

2. Create terraform.tfvars file:
   location       = "australiaeast"
   admin_username = "azureuser"
   admin_password = "YourSecurePassword123!"

3. Run Terraform Locally (Optional)
   terraform init
   terraform plan
   terraform apply

4. CI/CD via Azure DevOps
   Push changes to main branch. Pipeline in azure-pipelines.yml triggers automatically.

Security
-----------
• Sensitive variables like admin_password stored in Azure DevOps Variable Groups.
• .terraform/ and .tfvars excluded via .gitignore.

Contact
----------
Open an issue: https://github.com/your-username/terraform-hubspoke/issues

Image
----------

**The IP addresses, whether private or public, may differ from those shown in the illustration; this information is provided without prejudice.**

![image](https://github.com/user-attachments/assets/ba8a29ba-1ce2-4129-ab68-75f43f8904ba)
![image](https://github.com/user-attachments/assets/84929eba-2567-40dd-a49b-915e98cc4cb0)
![image](https://github.com/user-attachments/assets/e6ee7f78-1f3f-4e79-b0f1-250092d44c48)









📝 License
----------
This project is licensed under the MIT License.
