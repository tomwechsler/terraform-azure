# This configuration will add the following resources to the project:
# - A host pool and session host
# - A desktop application group and workspace

# Initialize terraform
terraform init

# Get values from the hub network deployment
$env:TF_VAR_hub_vnet_name = terraform -chdir="..\1-deploy-lab-environment" output -raw vnet_name
$env:TF_VAR_hub_vnet_id = terraform -chdir="..\1-deploy-lab-environment" output -raw vnet_id
$env:TF_VAR_hub_vnet_resource_group = terraform -chdir="..\1-deploy-lab-environment" output -raw vnet_resource_group
$env:TF_VAR_dc_private_ip_address = terraform -chdir="..\1-deploy-lab-environment" output -raw dc_private_ip_address
$env:TF_VAR_session_host_domain = terraform -chdir="..\1-deploy-lab-environment" output -raw dc_domain

# Set values for the session host
$env:TF_VAR_session_host_admin_username = "avdAdmin"
$env:TF_VAR_session_host_admin_password = "SET_ME_PLEASE"
$env:TF_VAR_session_host_domainuser = "admin@domain.xyz"
$env:TF_VAR_session_host_domainpassword = "SET_ME_PLEASE"
$env:TF_VAR_session_host_oupath = "SET_ME_PLEASE"


# Run terraform apply to create the session host
terraform apply -auto-approve