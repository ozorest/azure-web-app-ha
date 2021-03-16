# Azure Web App HA

A simple module that deploy an AppGateway + VM ScaleSets to deploy a web application with HA at Azure

## Usage

```
module "azure-web-app-ha" {
  source = "git@github.com:ozorest/azure-web-app-ha.git"

  project = "xpto"
  location = "brazilsouth"
  admin_username = var.username
  admin_password = var.password
}
```

### Variables


|Variables  |Default  |Description  |Required  |
|---------|---------|---------|---------|
|project     |         |Used as prefix to name the resources inside Azure         |Yes         |
|admin_password     |         |Password for the admin user         |Yes         |
|admin_username     |admusr         |Admin user for access the servers         |No         |
|location     |brazilsouth         |Location to deploy the Azure resources         |No         |
|address_space     |["10.0.0.0/16"]         |IP address range for the virtual network         |No         |
|backend_address_prefixes     |["10.0.2.0/24"]         |IP address range for the backend layer subnet         |No         |
|frontend_address_prefixes     |["10.0.2.0/24"]         |IP address range for the frontend layer subnet         |No         |
|nodes     |3         |Number of servers for the web app (backend) layer        |No         |
|machine_size     |Standard_DS1_v2         |The size of the servers         |No         |
|image_publisher     |Canonical         |The publisher of the OS image         |No         |
|image_offer     |UbuntuServer         |The offering of the OS image         |No         |
|image_sku     |20.04-LTS         |The version of the OS         |No         |
|image_version     |latest         |The version of the image         |No         |
|private_key_path     |~/.ssh/id_rsa.pub         |Path of the user private key         |No         |
|cloud_init_path     |         |Path of the custom defined cloud-init         |No         |