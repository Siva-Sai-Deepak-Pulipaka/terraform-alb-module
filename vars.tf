variable "env" {}
variable "tags" {}
variable "name" {}
variable "load_balancer_type" {}
variable "enable_deletion_protection" {
    default = false
}
variable "subnets" {}