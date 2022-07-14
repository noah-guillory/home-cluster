resource "proxmox_vm_qemu" "control-node" {
  name        = "k8s-0"
  target_node = "proxmox"

  clone = "fedora-36-cloudinit-template"

  onboot   = true
  oncreate = true
  agent    = 1

  memory = 1024
  vcpus  = 1

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

resource "proxmox_vm_qemu" "worker-node-1" {
  name        = "k8s-1"
  target_node = "proxmox"

  clone = "fedora-36-cloudinit-template"

  onboot   = true
  oncreate = true
  agent    = 1

  memory = 1024
  vcpus  = 1

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

resource "proxmox_vm_qemu" "worker-node-2" {
  name        = "k8s-2"
  target_node = "proxmox"

  clone = "fedora-36-cloudinit-template"

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
