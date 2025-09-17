# Terraform-azure
This project deploys a Linux Virtual Machine in Azure using Terraform, including networking, NSG, and optional managed disks.

# Prerequisites
- Terraform installed
- Azure CLI logged in (az login)
- Azure subscription with permissions to create resources
- Optional: SSH key (~/.ssh/id_rsa.pub) for VM access

## 📂 Project Structure

- terraform-azure/
- backend.tf          # Backend configuration
- provider.tf         # Azure provider
- vm.tf               # VM and networking resources
- variable.tf         # Variables for configuration
- output.tf           # Output resource info

 ## Commands to Run

1. **Initialize Terraform**
```bash
terraform init
```
2. **Check if code is valid**
```bash
terraform validate
```
3. **Format configuration**
```bash
terraform fmt
```
4. **Create an execution plan**
```bash
terraform plan 
```
5. **Apply the configuration**
```bash
 terraform apply 
 terraform apply -auto-approve
```
6. **Destroy the configuration**
```bash
terraform destroy 
terraform destroy -auto-approve
```
7. **View outputs after apply**
```bash
terraform output 
```

8. **List resources in the state**
```bash
terraform state list
#Show details of a specific resource
terraform state show <resource_name>
```
9. **Work with multiple environments (workspaces)**
```bash
terraform workspace list
terraform workspace new dev
terraform workspace select dev
```
------------------------------------
# Outputs

- Resource Group name
- VM name
- VM public IP
- VM size
- OS disk size
- Managed disk size (if attached)

# Notes
- Free-tier eligible VM is used (Standard_B1s).
- Ensure backend storage account exists before terraform init.
