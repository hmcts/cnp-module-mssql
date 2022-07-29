variable "resource_group_name" {
  default =  "rg-test-fk10"
  description = "(Required) The resource group you wish to put your Vault in. This has to exist already. (run step1)"
}

variable "key_vault_name" {
   default =  "kv-test-fk10"
  description = "(Required) The key vault you wish to put your vault secrets in. This has to exist already. (run step2)"
}

variable "common_tags" {
  type = map
  default = {}
}

variable "raw_product" {
  default = "test-raw-product"
}

variable "product" {  
  default = "testproduct"
}

variable "env" {
  type = string
  default = "test1"
}

variable "component" {
  default = "test-component"
}

variable "subscription" {
  default = "test-sub"
}

variable "location" {
  default = "West Europe"//"UK South"
}

/* variable "tenant_id" {
  type        = string
  description = "The Tenant ID of the Azure Active Directory"
  default = "b37e8421-56ad-4823-bb0a-c85030efec12"
} */

/* variable "jenkins_AAD_objectId" {
  type        = string
  description = "This is the ID of the Application you wish to give access to the Key Vault via the access policy"
  default = "b37e8421-56ad-4823-bb0a-c85030efec12"
} */

variable "storage_mb" {
  type        = string
  description = "Storage MB for MS SQL DB"
  default = "179200"
}

/* variable "object_id" {
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  default     = "b37e8421-56ad-4823-bb0a-c85030efec12"
} */