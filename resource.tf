resource "azurerm_resource_group" "res_group" {
  name = "rg-test"
  location = "eastus"
}
provider "azurerm" {
  features {
    
  }
}
resource "azurerm_resource_group_template_deployment" "network_watcher" {
    name                  = "network-watcher-deployment"
    resource_group_name   = azurerm_resource_group.res_group.name
    deployment_mode       = "Incremental"
    template_content      = file("template.json")
    parameters_content  = <<PARAMETERS
    {
        "name": {
            "value": "network-wather-example"
        },
        "location": {
            "value": "${azurerm_resource_group.res_group.location}"
        }
    }
    PARAMETERS
    depends_on = [
        azurerm_resource_group.res_group
    ]
}