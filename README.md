Terraform Hub-Spoke Architecture on Azure
=========================================

This project provisions a Hub-and-Spoke network topology on Microsoft Azure using Terraform, with deployment through Azure DevOps pipelines. It’s designed for learning, experimentation, and showcasing Infrastructure as Code (IaC) with remote backend state management and CI/CD automation.

Project Structure
--------------------
terraform-hubspoke/
├── main.tf                # Core infrastructure setup
├── variables.tf           # Input variables
├── outputs.tf             # Output values
├── backend.tf             # Remote backend configuration
├── vm.tf                  # VM configuration
├── nsg.tf                 # Network security groups
├── dns.tf                 # DNS Zone and A records
├── route_table.tf         # Route tables
├── monitor.tf             # Monitoring configuration
├── vpn.tf                 # VPN Gateway setup
├── firewall.tf            # Azure Firewall deployment
├── azure-pipelines.yml    # Azure DevOps CI/CD pipeline
├── .gitignore
└── README.md

Features
-----------
• Hub-and-Spoke Network with centralized routing
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
![image](https://github.com/user-attachments/assets/b73ffb5b-6e26-4e18-92ed-2e3cc2ddc0b4) ![image](https://github.com/user-attachments/assets/168e2a0e-b84a-4123-9175-de8a744e8b02)




📝 License
----------
This project is licensed under the MIT License.
