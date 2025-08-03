terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.8.3"
    }
  }
}

# Configure the Libvirt provider
provider "libvirt" {
  uri = var.libvirt_default_uri
}