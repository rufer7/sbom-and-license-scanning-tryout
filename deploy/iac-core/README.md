# Deploy resources to host terraform state

1. Make sure terraform and Azure CLI are installed:

```PowerShell
winget install -e --id Microsoft.AzureCLI
winget install -e --id Hashicorp.Terraform
```

2. Rename and adjust values in `vars/*.c1.tfvars`

3. Create resources to host terraform state with the following commands

```PowerShell
az login -t [tenant id]
cd [PATH_TO_REPOSITORY]\deploy\iac-core
terraform init
terraform apply --var-file .\vars\[ENVIRONMENT].c1.tfvars --state=[ENVIRONMENT].c1.tfstate
```

---

**NOTE**

In some cases the following error may appear because of insufficient permissions. Try to login to Azure again and reapply the changes with terraform.

_Error: reading queue properties for AzureRM Storage Account "[StorageAccount]": queues.Client#GetServiceProperties: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="AuthorizationPermissionMismatch" Message="This request is not authorized to perform this operation using this permission._

---
