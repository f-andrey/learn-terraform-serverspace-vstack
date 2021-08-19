variable "ubuntu" {
  type        = string
  description = "Default LTS"
  default     = "Ubuntu-20.04-X64"
}

variable "freebsd" {
  type        = string
  description = "FreeBSD 13"
  default     = "Freebsd-13.0-X64"
}

variable "am_location" {
  type        = string
  description = "am location"
  default     = "am2"
}

variable "ssh_key_path" {
  type        = string
  description = "The file path to an ssh public key"
  default     = "~/.ssh/id_ed25519_terr.pub"
}


variable "ssh_private_key_path" {
  type        = string
  sensitive   = true
  description = "The file path to an ssh privte key"
  default     = "~/.ssh/id_ed25519_terr"
}
