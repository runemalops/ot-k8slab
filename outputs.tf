output "ip" {
  value = libvirt_domain.domain_ubuntu_resized.network_interface[0].addresses[0]
}