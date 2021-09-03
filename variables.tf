variable "prefix" {
  description = "El prefijo que usaran todos los recursos del ejemplo"
  default     = "adrian"
}

variable "location" {
  description = "La región donde estarán los recursos"
  default     = "eastus"
}

variable "subscriptionID" {
  type        = string
  description = "Subscription ID"
  default     = "8d930efc-8b85-49af-956b-1de938b973c1"
}

variable "tenantID" {
  type        = string
  description = "Tenant ID"
  default     = "b66b40ad-ddc5-436a-a028-4e21acc4879d"
}

#variable "clientID" {
#  type        = string
#  description = "Client ID"
#  default     = "7ffa70fc-d905-4801-b2d9-324930920759"
#}