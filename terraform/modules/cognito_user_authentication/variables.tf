variable "admin_callback_url" {
  description = "Callback URL for operations user pool"
  type        = string
}

variable "admin_email" {
  description = "Email address for operations admin user"
  type        = string
}

variable "admin_user_role_name" {
  description = "Name of the admin user role"
  type        = string
}

variable "tenant_callback_url" {
  description = "Callback URL for tenant user pool"
  type        = string
  default = "https://example.com"
}