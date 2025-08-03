variable "ssh_public_key" {
  description = "The SSH public key content."
  type        = string
  sensitive   = true # Mark as sensitive to prevent logging
}