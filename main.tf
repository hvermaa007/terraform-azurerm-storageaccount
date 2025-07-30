# modules/azure-storage-account/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = lower(replace("${var.name_prefix}${var.name_suffix}", "/[^a-z0-9]/", ""))
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  access_tier              = var.access_tier
  enable_https_traffic_only = var.https_traffic_only
  min_tls_version          = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_blob_public_access

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
      bypass                     = network_rules.value.bypass
    }
  }

  blob_properties {
    delete_retention_policy {
      days = var.blob_retention_days
    }
    container_delete_retention_policy {
      days = var.container_retention_days
    }
    versioning_enabled = var.blob_versioning_enabled
    change_feed_enabled = var.change_feed_enabled
  }

  tags = merge(var.tags, {
    environment = var.environment
  })
}

resource "azurerm_storage_container" "containers" {
  for_each              = toset(var.containers)
  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = var.container_access_type
}
