variable "env_code" {
  type        = string
  description = "Environment Code (e.g. abcd-09)"
}
variable "default_location" {
  type        = string
  description = "Default Azure resource location"
}
variable "resource_group_tags" {
  type        = map(string)
  default     = {}
  description = "Base set of tags to apply to the Azure resource group."
}
variable "service_tags" {
  type        = map(string)
  default     = {}
  description = "Base set of tags to apply to Azure services."
}
variable "stage" {
  type        = string
  description = "Deployment stage"
  validation {
    condition     = contains(["prod", "int", "test", "dev"], var.stage)
    error_message = "Deployment stage must be one of 'prod', 'int', 'test', 'dev'."
  }
}
variable "customer" {
  type        = string
  description = "Customer Alias"
}
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}
variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}
variable "solution_name" {
  type        = string
  description = "Solution name"
}
variable "app_worker_count" {
  type        = number
  description = "Number of App Instances/Workers"
}
variable "app_sku_name" {
  type        = string
  description = "App Plan SKU e.g B1, S1, P1v2, I1v1, P1v3, I1v2 (1-3)"
}
variable "app_logo_name" {
  type        = string
  description = "Name of the app logo e.g. icon.png"
}
variable "custom_domain_name" {
  type        = string
  description = "Custom Domain Name for App Srvice"
}
