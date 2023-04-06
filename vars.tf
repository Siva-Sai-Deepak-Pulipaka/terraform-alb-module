variable "env" {}
variable "tags" {}
variable "name" {}
variable "load_balancer_type" {}
variable "enable_deletion_protection" {
    default = false
}
variable "subnets" {}
variable "internal" {}
variable "vpc_id" {}
variable "allow_cidr" {}