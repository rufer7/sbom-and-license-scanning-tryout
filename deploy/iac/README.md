# Deploy application resources

## 1. Make sure terraform and Azure CLI are installed:

```PowerShell
winget install -e --id Microsoft.AzureCLI
winget install -e --id Hashicorp.Terraform
```

## 2. Adjust values in `vars/*.tfvars` and `backend/*.backend.tfvars`

## 3. Login to Azure

```PowerShell
az login -t [tenant id]
```

### d1
```PowerShell
az login -t cfb4b9e7-33b8-4d91-9e79-7c7bd27fbcdf
```

## 4. Initialize terraform

```PowerShell
.\Initialize-Terraform.ps1
```

- EnvironmentCode: [Environment Code e.g. d1, p1]
- BackendName: [Name of the configuration file prefix [BackendName].backend.tfvars]

## 5. Deploy resources

```PowerShell
terraform apply
```

---

**NOTE**

It may occur that the following error appears while creating the resources. This happens when terraform tries to add secrets to the key vault before the user has the necessary rights to do so. It should work when you try to perform the `terraform apply` command again after a few minutes.

_Error: checking for presence of existing Secret "[SecretName]"
keyvault.BaseClient#GetSecret: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="Forbidden" Message="Caller is not authorized to perform action on resource.\r\nIf role assignments, deny assignments or role definitions were changed recently, please observe propagation time._

---
