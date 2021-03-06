#The value of empty variables will be defined when deploying.

variable "product" {}

variable "location" {}
variable "component" {
  default = ""
}

variable "name" {
  default = ""
}

variable "env" {}

variable "mssql_listen_port" {
  default = "1433"
}

variable "mssql_user" {}

# sku supports the following:
# - skuName: Possible values are:
#            B_Gen5_1    (Basic)
#            B_Gen5_2    (Basic)
#            GP_Gen5_2   (GeneralPurpose)
#            GP_Gen5_4   (GeneralPurpose)
#            GP_Gen5_8   (GeneralPurpose)
#            GP_Gen5_16  (GeneralPurpose)
#            GP_Gen5_32  (GeneralPurpose)
#            MO_Gen5_2   (MemoryOptimised)
#            MO_Gen5_4   (MemoryOptimised)
#            MO_Gen5_8   (MemoryOptimised)
#            MO_Gen5_16  (MemoryOptimised)
#            MO_Gen5_32  (MemoryOptimised)

# - tier     : Specifies the SKU Tier for this PostgreSQL Server.
#              Possible values are "Basic", "GeneralPurpose", "MemoryOptimized".
variable "sku_name" {
  default = "GP_Gen5_2"
}

variable "sku_tier" {
  default = "GeneralPurpose"
}

# This is actually the vCores when template is run
variable "sku_capacity" {
  default = "2"
}

# Valid values are 10 and 11.
variable "mssql_version" {
  type = string
}


# variable "storage_mb" {
#   default = "51200"
# }

# # Min 7 days, max 35 days
# variable "backup_retention_days" {
#   default = "35"
# }

# # Possible values are true and false.
# variable "georedundant_backup" {
#   default = "true"
# }

# variable "charset" {
#   default = "utf8"
# }

variable "collation" {
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "database_name" {}

variable "common_tags" {
  type = map(any)
}

variable "subscription" {
  description = "the human friendly name of the subscription, ie. qa, or prod"
}

variable "subnet_id" {
  default     = ""
  description = "the subnet to put the private endpoint in"
}

variable "key_vault_name" {
  description = "the human friendly name of the key vault where the github api key resides"
  default     = ""
}

variable "key_vault_rg" {
  description = "the human friendly name of the resource group where the key vault resides"
  default     = ""
}

variable "subnets_filename" {
  description = "Filename of the subnets file in the cnp-database-subnet-whitelisting repo"
  default     = "subnets.json"
}

variable "business_area" {
  description = "Business Area."
  default     = "CFT"
}

# variable "auto_grow_enabled" {
#   description = "auto grow Storage."
#   type = bool
#   default = true
# }
