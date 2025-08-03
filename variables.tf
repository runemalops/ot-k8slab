variable "ssh_public_key" {
  description = "The SSH public key content."
  type        = string
  sensitive   = true # Mark as sensitive to prevent logging
}

variable "libvirt_default_uri" {
  description = "The Default URI used to connect into Qemu"
  type = string
}