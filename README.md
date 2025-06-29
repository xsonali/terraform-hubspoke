Terraform Hub-Spoke Architecture on Azure
=========================================

This project provisions a Hub-and-Spoke network topology on Microsoft Azure using Terraform, deployed via Azure DevOps pipelines. It is a production-ready solution designed for professional use, technical reference, skill development, and experimentation. The implementation exemplifies Infrastructure as Code (IaC) best practices, featuring remote backend state management, CI/CD automation, and seamless integration between a local development environment and a GitHub repository to ensure efficient delivery. Effective implementation requires a thorough understanding of Terraform code, the Azure cloud platform, and the associated DevOps environments.

--------------------
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

## **Features**

• Hub-and-Spoke network architecture with centralized routing, traffic management, private DNS, and enhanced security posture
• Network Security Groups (NSGs) and Azure Firewall rules for comprehensive traffic control
• Automated deployment of Linux and Windows VMs using cloud-init
• Azure DNS zones and A record management for internal and external name resolution
• Point-to-Site (P2S) VPN connection setup for secure remote access
• Remote state management leveraging Azure Blob Storage for Terraform backend
• Continuous Integration and Continuous Deployment (CI/CD) pipeline implemented via Azure DevOps

Getting Started
------------------
✅ **Prerequisites**

• Azure Subscription
• Terraform CLI installed
• Azure DevOps Project
• Azure Storage Account configured for remote backend
• Service Principal with Contributor or Owner access
• Service Connection created using the correct Service Principal, scoped to the appropriate folder and Azure DevOps project


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
