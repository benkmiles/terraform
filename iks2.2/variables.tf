variable "apikey" {
  type        = string
  description = "API Key"
}
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
}
variable "endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
variable "ssh_user" {
  type        = string
  description = "SSH Username for node login."
}
variable "ssh_key" {
  type        = string
  description = "ssh key for login"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMuIoIWBnRyugOWVcZS06ZQPL4jtmefVMJoZ+SYb2JwO eddsa-key-20210923"
}    
variable "vcPassword" {
  type        = string
  description = "vCenter Password"
}  
variable "tags" {
  type    = list(map(string))
  default = []
}
variable "ClusterName" {
  type  = string
  description = "IKS Cluster Name to Add"
  default = "Ben-IKS-Cluster3"
}
variable "apic_url" {}
variable "apic_username" {}
variable "apic_password" {}
variable "api_key_id" {}
variable "api_private_key" {}
