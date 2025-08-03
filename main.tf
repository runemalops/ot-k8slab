resource "libvirt_volume" "os_image_ubuntu" {
  name = "os_image_ubuntu"
  pool = "default"
  source = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

resource "libvirt_volume" "disk_ubuntu_resized" {
  name           = "disk"
  base_volume_id = libvirt_volume.os_image_ubuntu.id
  pool           = "default"
  size           = 10737418240
}

resource "libvirt_cloudinit_disk" "cloudinit_ubuntu_resized" {
  name = "cloudinit_ubuntu_resized.iso"
  pool = "default"

  user_data = <<EOF
#cloud-config
disable_root: true
ssh_pwauth: false
users:
  - name: ptty2u
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${var.ssh_public_key}

growpart:
  mode: auto
  devices: ['/']
EOF
}

resource "libvirt_domain" "domain_ubuntu_resized" {
  name   = "domain_ubuntu_resized"
  memory = "512"
  vcpu   = 1

  cloudinit = libvirt_cloudinit_disk.cloudinit_ubuntu_resized.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  console {
    type = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.disk_ubuntu_resized.id
  }
}