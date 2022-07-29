//if you get this error "checking for presence of existing Secret "db-manager-password" on first "terraform apply", try to run "terraform apply" again

//run below commands:
// -->az login
// -->az ad signed-in-user show
//You will get signed user info. Overwrite below default value with returned "id" value.
variable "user-object-id" {
  default = "26df1e24-a1d1-4317-b583-1e8af8a03ee1"
  description = "The vault name (at most 24 characters - Azure Key Vault name limit). If not provided then product-env pair will be used as a default."
}

variable "rg-name" {
  default = "rg-test-fk10"
  description = "The resource group name. This has to exist already. (run step1)"
}

variable "location" {
  default = "West Europe"
  description = "Resource group location"
}

variable "kv-name" {
  default = "kv-test-fk10"
  description = "The vault name (at most 24 characters - Azure Key Vault name limit)."
}

variable "sku" {
  default     = "standard"
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
}

variable "purge_protection_enabled" {
  default = true
}

variable "network_acls_allowed_ip_ranges" {
  description = "IP Address space Allowed"
  type        = list(string)
  default     = []
}

variable "network_acls_default_action" {
  default = "Allow"
}

variable "network_acls_allowed_subnet_ids" {
  description = "Allowed subnet id(s)"
  type        = list(string)
  default     = []
}

variable "common_tags" {
  type = map(string)
  default     = {}
}