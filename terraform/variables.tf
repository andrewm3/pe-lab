variable "external_gateway" {
  description = "The ID for the external gateway network."
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa.terraform"
}

variable "pool" {
  default = "public"
}

variable "pe_source_url" {
  description = "Location of the Puppet Enterprise installer"
  default     = "https://pm.puppetlabs.com/cgi-bin/download.cgi?dist=el&rel=7&arch=x86_64&ver=latest"
}
