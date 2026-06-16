resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-monitoring-lab"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku               = "PerGB2018"
  retention_in_days = 30
}


resource "azurerm_monitor_data_collection_rule" "vm_dcr" {
  name                = "dcr-vm-logs"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
      name                  = "law-destination"
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf"]
    destinations = ["law-destination"]
  }

  data_sources {
    performance_counter {
      name                          = "vm-performance-counters"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor Information(_Total)\\% Processor Time",
        "\\Memory\\Available MBytes"
      ]
    }
  }
}

# Alert for CPU > 80 for 5 min

resource "azurerm_monitor_action_group" "email_alert" {
  name                = "ag-cpu-alert"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "cpuAlert"

  email_receiver {
    name          = "admin-email"
    email_address = "paultiemele@gmail.com"
  }
}

resource "azurerm_monitor_metric_alert" "high_cpu_vm" {
  name                = "high-cpu-vm-alert"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = azurerm_windows_virtual_machine.winvm[*].id

  description = "Alert when VM CPU is greater than 80% for 5 minutes"
  severity    = 2
  enabled     = true

  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }
}