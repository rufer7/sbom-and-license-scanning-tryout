# initialisation of terraform
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, HelpMessage = "Environment Code e.g. d1, p1")]
    [string] $EnvironmentCode,
    [Parameter(Mandatory = $true, HelpMessage = "Name of the configuration file prefix [BackendName].backend.tfvars")]
    [string] $BackendName
)

# show some info
$subscriptionName = $(az account show -o tsv --query 'name')
$tenantId = $(az account show -o tsv --query 'tenantId')
$userId = $(az account show -o tsv --query 'user.name')
Write-Host "Your are currently logged in as $userId on $subscriptionName of Tenant $tenantId"

$env:TF_LOG = $null
$env:TF_CLI_ARGS_init = "--backend-config=.\\backend\\$($BackendName).backend.tfvars"
$env:TF_CLI_ARGS_plan = "--var-file .\\vars\\$($BackendName).$($EnvironmentCode).tfvars"
$env:TF_CLI_ARGS_apply = "--var-file .\\vars\\$($BackendName).$($EnvironmentCode).tfvars"
$env:TF_CLI_ARGS_destroy = "--var-file .\\vars\\$($BackendName).$($EnvironmentCode).tfvars"
$env:TF_CLI_ARGS_import = "--var-file .\\vars\\$($BackendName).$($EnvironmentCode).tfvars"

# init
&terraform init -reconfigure -upgrade

# set or create workspace
$workspaces = (&terraform workspace list).Split("\n")
if ($workspaces.Contains($EnvironmentCode) -eq $false -and $workspaces.Contains("* $EnvironmentCode") -eq $false ) {
    &terraform workspace new $EnvironmentCode
}
&terraform workspace select $EnvironmentCode

Write-Host "Initialized: Environment $EnvironmentCode on $BackendName"
