packer {
  required_plugins {
    azure = {
      version = ">= 1.4.1"
      source  = "github.com/hashicorp/azure"
    }
  }
}

# Azure auth
variable subscription-id            { default = env("ARM_SUBSCRIPTION_ID") }
variable client-id                  { default = env("ARM_CLIENT_ID") }
variable client-secret              { default = env("ARM_CLIENT_SECRET") }

# Image base
variable version                    { default = "10" }
variable feature-update             { default = "22h2-pro" }
variable vm-size                    { default = "Standard_D4_v5" }
variable location                   { default = "westus" }

# Config
variable admin-user                 { default = "hrqpadmin"}
variable admin-pass                 { default = "SuperS3cr3t!!!!" }
variable username                   { default = "rhqp" } 
variable password                   { default = "auN=vC%&27ITSj1<" }
variable authorized-keys            { default = "Required to be fullfilled during userdata exec" }

# Target
variable target-rgn                 { default = "QE_Platform" }

source "azure-arm" "this" {

  subscription_id       = var.subscription-id
  client_id             = var.client-id
  client_secret         = var.client-secret

  os_type               = "Windows"
  image_publisher       = "MicrosoftWindowsDesktop"
  image_offer           = "windows-${var.version}"
  image_sku             = "win${var.version}-${var.feature-update}"
  location              = var.location
  vm_size               = var.vm-size

  communicator          = "winrm"
  winrm_username        = var.admin-user
  winrm_password        = var.admin-pass
  winrm_timeout         = "5m"
  winrm_use_ssl         = true
  winrm_insecure        = true


  # Recommended property https://developer.hashicorp.com/packer/plugins/builders/azure/arm#user_data_file
  // user_data_file        = var.ud-winrm-script-default

  managed_image_resource_group_name = var.target-rgn
  // https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
  managed_image_name = "it-rhqp-win${var.version}-${var.feature-update}"

  azure_tags = {
    owner   = "ariobolo@redhat.com"
    team    = "rhqp"
  }
}

build {
  name    = "rhqp-win"

  sources = ["source.azure-arm.this"]

  // https://github.com/hashicorp/packer/issues/7729
  provisioner powershell {

    environment_vars = [
      "ADMIN_NAME=${var.admin-user}",
      "ADMIN_PASSWORD=${var.admin-pass}"]
    script           = "./enable-autologon.ps1"
  }
  provisioner "windows-restart" {}


  provisioner powershell {

    elevated_user = var.admin-user 
    elevated_password = var.admin-pass

    environment_vars = [
      "USERNAME=${var.username}",
      "PASSWORD=${var.password}",
      "AUTHORIZEDKEY=${var.authorized-keys}"]
    script           = "./setup.ps1"
  }

  post-processor manifest {
        output = "manifest.json"
        strip_path = true      
  }

  // TODO postscript to disable winrm
  // https://github.com/hashicorp/packer-plugin-azure/blob/main/example/windows.json
}
