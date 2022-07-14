terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }

    sops = {
      source  = "carlpett/sops"
      version = "0.7.1"
    }
  }
}

data "sops_file" "proxmox_secrets" {
  source_file = "secret.sops.yaml"
}


provider "proxmox" {
  pm_api_url          = data.sops_file.proxmox_secrets.data["pm_api_url"]
  pm_api_token_id     = data.sops_file.proxmox_secrets.data["pm_api_token_id"]
  pm_api_token_secret = data.sops_file.proxmox_secrets.data["pm_api_token_secret"]
  pm_timeout          = 600
}

resource "proxmox_lxc" "homebridge" {
  target_node  = "proxmox"
  hostname     = "homebridge"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged = true
  ostype       = "ubuntu"
  onboot       = true
  start        = true

  ssh_public_keys = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGZE+bfLVQTjheZBdxfoHr/08M8098BJ3oZqkGYiIt3Ce9SF1wvgHuNyk/uGyfO6+O7uU1iFAtG9BMi5YTZ8g4dLbrSvTOFppDtlnovlzrByjUanz+PX1+wg5KmIW87mcVLKah43QOSfi7xHEWzc/Jtnu1VnRM0NyR3xpmPcFUmK7aQGveqDNQo+McDG8oQrK/aE0EZTEX9i2yRId9Ns1cjhicqJ3an7IKFOSuCJapPn5xWmGliuqSbzRXQdUayAuZWSZg/25si6jAOCWdxr6SC7t6e+2081O89dXkCmLx6J2g3NBSTzcUB+Qj4tCTVLvy3XnEkEAmIqpZKa6z2jV5qFyOkbeweqLL+obmPq8HjqGB9L2EILm/qYjcYsrhQqQwnJxnRNFkjYwJ6JM5Ye8Wh56Tnt3zMsBuqcTL8GzhKH9Vjscj9TRY8LnUTkcezPRPg+Hw48bV55TifzZVLCH8zr7WLLPoansujLbQzZeRg8HWUuY9QG+bbC3ZVRYgsz1U6ig8MkDCHOYjrr6bJ/vOvfszAm5eoqhVvk1oUjOXT/oH1XVwOSehlYirKHAZx8xVYd/K1nRkBvwPguuvaauC1qzgWIvIRAhzM5BPuzY/G1BWx4Y1AvWa7Z2zZ49UbSc8CTpfFSxBBIlSIaso7WGdi4oeComJzFZhu8zg6s4buQ== cardno:18 308 019
  EOT

  rootfs {
    storage = "main-data"
    size    = "16G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = "172.16.0.1"
    ip     = "172.16.10.1/32"
  }
}
