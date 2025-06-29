Terraform Hub-Spoke Architecture on Azure
=========================================

This practical project provisions a Hub-and-Spoke network topology on Microsoft Azure using Terraform, deployed through Azure DevOps pipelines. It is a production-ready solution designed for professional environments, aligned with security best practices, and suitable for use as a technical reference, skill development platform, or experimentation space. The implementation follows Infrastructure as Code (IaC) principles, incorporating remote backend state management, CI/CD automation, and seamless integration between a local development environment and a GitHub repository to ensure efficient and reliable delivery. Successful deployment requires a solid understanding of Terraform, the Azure cloud platform, DevOps workflows, and YAML syntax for pipeline configuration.

--------------------
Project Structure
--------------------

terraform-hubspoke/
├── main.tf                 # Provider and resource group
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── backend.tf              # Remote backend configuration
├── vm.tf                   # Linux/Windows VM configuration
├── nsg.tf                  # Network Security Groups
├── dns.tf                  # Private and public DNS zones with A records configured for internal and external name resolution
├── route_table.tf          # Custom route tables
├── monitor.tf              # Monitoring and diagnostics
├── vpn.tf                  # VPN Gateway setup
├── firewall.tf             # Azure Firewall deployment with network and application rules configured for traffic filtering and security control
├── vnet_peering.tf         # VNet peering between Hub and Spoke for bidirectional communication
├── cloud-init-dns.yaml     # Cloud-init configuration for DNS VM and Apache2
├── azure-pipelines.yml     # Azure DevOps CI/CD pipeline definition
├── .gitignore              # Git ignored files
└── README.md               # Project documentation

## **Features**

• Hub-and-Spoke network architecture with centralized routing, traffic management, private DNS, and enhanced security posture
• VNet peering between Hub and Spoke for seamless and secure cross-network communication
• Network Security Groups (NSGs) and Azure Firewall rules for comprehensive traffic control
• Automated deployment of Linux and Windows VMs using cloud-init
• Azure DNS zones and A record management for internal and external name resolution
• Point-to-Site (P2S) VPN connection setup for secure remote access
• Option to configure Local Network Gateway for Site-to-Site (S2S) VPN connectivity
• Azure monitoring for centralized diagnostics and insights
• Remote state management leveraging Azure Blob Storage for Terraform backend
• Continuous Integration and Continuous Deployment (CI/CD) pipeline implemented via Azure DevOps

Getting Started
------------------
✅ **Prerequisites**

* Azure Subscription
* Terraform CLI installed
* Azure DevOps Project
* Azure Storage Account configured for remote backend
* Service Principal with Contributor or Owner access
* Service Connection created using the correct Service Principal, scoped to the appropriate folder and Azure DevOps project
* agent configuration at local desktop (I have used lower case 'a' instead of 'A')
* Avoid storing sensitive information like passwords in .tfvars files committed to the repo; use Azure DevOps Variable Groups instead. 

Deployment Steps
-------------------

> In this project, setting up the development environment is a step-by-step process that requires a solid understanding of Azure cloud architecture, intelligent network design, and hands-on experience.

1. Clone the Repository
   git clone https://github.com/your-username/terraform-hubspoke.git (Ensure you replace your-username with the actual username and local directory/folder)
   
   cd \Users\Alam\Desktop (Enter)
   
   cd terraform-hubspoke (Enter)

   PS C:\Users\Alam\Desktop\terraform-hubspoke>

3. Create terraform.tfvars file:
   location       = "australiaeast"
   admin_username = "azureuser"
   admin_password = "YourSecurePassword123!"

4. Run Terraform Locally (Optional)
   terraform init
   terraform plan
   terraform apply

5. CI/CD via Azure DevOps
   Push changes to main branch. Pipeline in azure-pipelines.yml triggers automatically.

### Security

* Sensitive variables such as `admin_password` are securely managed using Azure DevOps Variable Groups
* `.terraform/` and `.tfvars` files are excluded from version control via `.gitignore` to avoid exposing sensitive or stateful data
* The infrastructure codebase is organized into segmented and modular `.tf` files, promoting clarity, easier troubleshooting, and maintainability

Contact
----------
Open an issue: https://github.com/your-username/terraform-hubspoke/issues

Email: villshona@gmail.com (Sorry — I may not be able to reply to all messages)

Image
----------

**The IP addresses, whether private or public, may differ from those shown in the illustration; this information is provided without prejudice.**

![image](https://github.com/user-attachments/assets/ba8a29ba-1ce2-4129-ab68-75f43f8904ba)
![image](https://github.com/user-attachments/assets/4040b1d2-2b96-4872-b9ee-116527258388)
![image](https://github.com/user-attachments/assets/e6ee7f78-1f3f-4e79-b0f1-250092d44c48)
![image](https://github.com/user-attachments/assets/fdd4a39a-48e6-44b4-9543-1b932750b170)



📝 License
----------
This project is licensed under the MIT License.
