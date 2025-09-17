# ---Resource Group Name ---
resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg"
  location = var.location
}

# --- Virtual Network  ---

resource "azurerm_virtual_network" "terra_virtual_network" {
  name                = "terraformVm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

}

# --- Azure Subnet  ---

resource "azurerm_subnet" "terra_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.terra_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

# --- Public IP ---

resource "azurerm_public_ip" "terra_public_ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Basic" 

}

# --- Network Interface ---
resource "azurerm_network_interface" "terra_network_interface" {
  name                = "example-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.terra_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terra_public_ip.id
   }
}

# --- Network Security Group ---
resource "azurerm_network_security_group" "terra_nsg" {
  name                = "terraform-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Allow SSH (22)
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTP (80)
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  
}

# --- Associate NSG with NIC ---
resource "azurerm_network_interface_security_group_association" "terra_nic_nsg" {
  network_interface_id      = azurerm_network_interface.terra_network_interface.id
  network_security_group_id = azurerm_network_security_group.terra_nsg.id
}
 

# --- Linux Virtual Machine ---

resource "azurerm_linux_virtual_machine" "terra_vm" {
  name                = var.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.terra_network_interface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type =  var.storage_type
    disk_size_gb         =  var.storage_size
}

  source_image_reference {
  publisher = var.vm_image_publisher
  offer     = var.vm_image_offer
  sku       = var.vm_image_sku
  version   = var.vm_image_version
 }
}

/*
# Create a 10 GB managed disk
resource "azurerm_managed_disk" "terra_disk" {
  name                 = "terra-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = var.storage_type
  create_option        = "Empty"
  disk_size_gb         =  var.storage_size
}

# --- Attach external Disk ----

resource "azurerm_virtual_machine_data_disk_attachment" "terra_attach_disk" {
  managed_disk_id    = azurerm_managed_disk.terra_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.terra_vm.id
  lun                = 0
  caching            = "ReadWrite"
}
 
*/
