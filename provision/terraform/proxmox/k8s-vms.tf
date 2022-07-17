resource "proxmox_vm_qemu" "control-node-1" {
  name        = "k8s-control-1"
  target_node = "proxmox"

  clone = "ubuntu-2204-cloudinit-template"

  onboot   = true
  oncreate = true
  agent    = 1

  memory = 2048
  vcpus  = 2

  ipconfig0 = "gw=172.16.0.1,ip=172.16.11.2/16"
  network {
    model  = "e1000"
    bridge = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = "main-data"
    size    = "16G"
  }
}

resource "proxmox_vm_qemu" "control-node-2" {
  name        = "k8s-control-2"
  target_node = "proxmox"

  clone = "ubuntu-2204-cloudinit-template"

  onboot   = true
  oncreate = true
  agent    = 1

  memory = 2048
  vcpus  = 2

  ipconfig0 = "gw=172.16.0.1,ip=172.16.11.3/16"
  network {
    model  = "e1000"
    bridge = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = "main-data"
    size    = "16G"
  }
}

resource "proxmox_vm_qemu" "worker-node-1" {
  name        = "k8s-worker-1"
  target_node = "proxmox"

  clone = "ubuntu-2204-cloudinit-template"

  onboot   = true
  oncreate = true
  agent    = 1

  memory = 1024
  vcpus  = 1

  ipconfig0 = "gw=172.16.0.1,ip=172.16.11.4/16"
  network {
    model  = "e1000"
    bridge = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = "main-data"
    size    = "16G"
  }
}

resource "proxmox_vm_qemu" "worker-node-2" {
  name        = "k8s-worker-2"
  target_node = "proxmox"

  clone = "ubuntu-2204-cloudinit-template"

  onboot   = true
  oncreate = true
  agent    = 1

  memory = 1024
  vcpus  = 1

  ipconfig0 = "gw=172.16.0.1,ip=172.16.11.5/16"
  network {
    model  = "e1000"
    bridge = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = "main-data"
    size    = "16G"
  }
}
