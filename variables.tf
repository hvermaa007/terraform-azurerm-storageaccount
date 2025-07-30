# modules/azure-storage-account/variables.tf

variable "name_prefix" {
  description = "Prefix for the storage account name"
  type        = string
  default     = "st"
}

variable "name_suffix" {
  description = "Suffix for the storage account name (will be made lowercase and alphanumeric)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where storage account will be created"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage account replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "Storage account kind (StorageV2, BlobStorage, FileStorage, BlockBlobStorage)"
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Access tier for BlobStorage and StorageV2 accounts (Hot or Cool)"
  type        = string
  default     = "Hot"
}

variable "https_traffic_only" {
  description = "Allow only HTTPS traffic"
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version for requests"
  type        = string
  default     = "TLS1_2"
}

variable "allow_blob_public_access" {
  description = "Allow public access to blobs"
  type        = bool
  default     = false
}

variable "network_rules" {
  description = "Network rules for storage account"
  type = object({
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
    bypass                     = list(string)
  })
  default = null
}

variable "blob_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 7
}

variable "container_retention_days" {
  description = "Number of days to retain deleted containers"
  type        = number
  default     = 7
}

variable "blob_versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "change_feed_enabled" {
  description = "Enable change feed for blob storage"
  type        = bool
  default     = false
}

variable "containers" {
  description = "List of containers to create"
  type        = list(string)
  default     = []
}

variable "container_access_type" {
  description = "Access type for containers (private, blob, container)"
  type        = string
  default     = "private"
}

variable "environment" {
  description = "Environment tag value"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
