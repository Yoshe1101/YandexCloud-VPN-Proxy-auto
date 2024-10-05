variable "networkid" {
  description = "Network ID"
  type        = string
}
variable "subnetid" {
  description = "Subnet ID"
  type        = string
}
variable "vmname" {
  description = "VM name"
  type        = string
}

variable "zone" {
  description = "Zone"
  type        = string
  default     = "ru-central1-a"
}
variable "imageid" {
  description = "OS image ID"
  type        = string
  default     = "fd8j0uq7qcvtb65fbffl"
}
