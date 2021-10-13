variable "owner" {
  type        = string
  description = "The person or group who launched these resources."
}

variable "purpose" {
  type        = string
  description = "Detailed description for why these resources are being launched."
}

variable "ttl" {
  type        = string
  description = "Time in hours from the launch that a resource can be stopped/terminated. Use -1 for permanent resources."
  default     = "48"
}

variable "tfe-workspace" {
  type        = string
  description = "(org/workspace) Makes it easier to find where resources were created."
  default     = ""
}

variable "lifecycle-action" {
  type        = string
  description = "(stop|terminate) By default all instances exceptional resources are terminated. This allows them to be stopped instead where that’s a capability."
  default     = "stop"
}

variable "config-as-code" {
  type        = string
  description = "This is a potential replacement for the mandatory 'terraform' tag and allows for some flexibility to surface other infrastructure provisioning tools."
  default     = "terraform"
}

variable "repo" {
  type        = string
  description = "If a config-as-code value is set, the repository that holds the code used to create this resource."
  default     = ""
}
