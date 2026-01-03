#-----------
# Public IP
#-----------
resource "azurerm_public_ip" "public_ip" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = var.allocation_method
  zones                   = var.sku == "Standard" ? try(var.zones, [1]) : null
  ddos_protection_mode    = try(var.ddos_protection_mode, "VirtualNetworkInherited")
  ddos_protection_plan_id = var.ddos_protection_mode == "Enabled" ? var.ddos_protection_plan_id : null
  domain_name_label       = try(var.domain_name_label, null)
  edge_zone               = try(var.edge_zone, null)
  idle_timeout_in_minutes = try(var.idle_timeout_in_minutes, 4)
  ip_tags                 = var.zones != null && var.sku == "Standard" ? try(var.ip_tags, {}) : {}
  ip_version              = try(var.ip_version, "IPv4")
  public_ip_prefix_id     = try(var.public_ip_prefix_id, null)
  reverse_fqdn            = try(var.reverse_fqdn, null)
  sku                     = var.allocation_method == "Static" ? "Standard" : "Basic"
  sku_tier                = try(var.sku_tier, "Regional")

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["creation_timestamp"],
    ]
  }
}