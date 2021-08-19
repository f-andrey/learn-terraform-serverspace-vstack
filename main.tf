terraform {
  required_providers {
    serverspace = {
      version = "~> 0.2.0"
      source  = "itglobalcom/serverspace"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="api_key=..." CLI option
variable "api_key" {}

# Configure the Serverspace Provider
provider "serverspace" {
  key = var.api_key
}

locals {
  current_location = var.am_location
}


resource "serverspace_ssh" "my_ssh" {
  name       = "terraformtest key"
  public_key = file("~/.ssh/id_ed25519_terr.pub")
}

resource "serverspace_isolated_network" "my_net" {
  location       = local.current_location
  name           = "my_net"
  description    = "Internal network"
  network_prefix = "192.168.0.0"
  mask           = 24
}


resource "serverspace_server" "vm1" {
  name     = "terraformtest1.buidl1.cloud.bsdnir.info"
  image    = var.freebsd
  location = local.current_location
  cpu      = 1
  ram      = 1024

  boot_volume_size = 30 * 1024

  volume {
    name = "external1"
    size = 30 * 1024
  }

  nic {
    network      = serverspace_isolated_network.my_net.id
    network_type = "Isolated"
    bandwidth    = 0
  }
  nic {
    network      = ""
    network_type = "PublicShared"
    bandwidth    = 50
  }

  ssh_keys = [serverspace_ssh.my_ssh.id]


  connection {
    host        = self.public_ip_addresses[0] # Read-only attribute computed from connected networks
    user        = "root"
    type        = "ssh"
    private_key = file("~/.ssh/id_ed25519_terr")
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      # install nginx
      "pkg update",
      "pkg upgrade -y",
      "pkg install -y vim-console git-lite nginx-devel"
    ]
  }
}


output "my_net" {
  value = serverspace_isolated_network.my_net
}

output "vm1" {
  value = serverspace_server.vm1
}
