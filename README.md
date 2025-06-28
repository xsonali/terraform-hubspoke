Terraform Hub-Spoke Architecture on Azure
This project provisions a Hub-and-Spoke network topology on Microsoft Azure using Terraform and deploys it via Azure DevOps pipelines. It is designed for learning, experimentation, and demonstrating Infrastructure as Code (IaC) with remote backend state management and CI/CD automation.
📁 Project Structure

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
•	Hub-and-Spoke Network with centralized routing
•	NSG and Firewall rules for network control
•	Linux/Windows VM deployment with cloud-init support
•	DNS zone and A records for custom domains
•	Azure DevOps CI/CD Pipeline for automated deployment
•	Remote state management via Azure Blob Storage
Getting Started
✅ Prerequisites
•	Azure Subscription
•	Terraform CLI installed
•	Azure DevOps project
•	A Service Connection in Azure DevOps (SP with Contributor or Owner access)
•	Storage account for remote backend state
Deployment Steps
1.	Clone the repository
git clone https://github.com/your-username/terraform-hubspoke.git
cd terraform-hubspoke
2.	Configure variables
Create a terraform.tfvars file:

location       = "australiaeast"
admin_username = "azureuser"
admin_password = "P@ssw0rd123!"
3.	Run Terraform locally (optional)
terraform init
terraform plan
terraform apply
4.	Use Azure DevOps Pipeline
Commit your changes and push to the main branch. The pipeline in azure-pipelines.yml will run automatically.
Security
Sensitive variables like admin_password are stored securely in Azure DevOps Variable Groups. The .terraform/ directory and .tfvars are excluded via .gitignore.
Contact
For any questions or contributions, feel free to reach out via GitHub Issues:
https://github.com/your-username/terraform-hubspoke/issues
📝 License
This project is licensed under the MIT License.

