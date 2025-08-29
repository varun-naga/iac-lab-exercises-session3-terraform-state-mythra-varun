variable "prefix" {
  description = "prefix to the resources"
  type        = string
}
variable "region" {
  type        = string
  description = "Region to deploy the resources"
}
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}
variable "number_of_public_subnets" {
  description = "Number of public subnets to create"
  type        = number
  default     = 2
}
variable "number_of_private_subnets" {
  description = "Number of private subnets to create"
  type        = number
  default     = 2
}
variable "number_of_secure_subnets" {
  description = "Number of secure subnets to create"
  type        = number
  default     = 2
}
variable "vpc_id" {

}
variable"lb_sg"{

}
variable "private_subnet_ids" {
  //type = list(string)
}
variable alb_security_group_id{
    description = "Security group ID associated with the ALB"
    type        = string
}
variable "alb_target_group_arn" {
    # description = "ARN of the ALB target group"
    # type        = string
}
variable"db_address"{
    description = "RDS endpoint address"
    type        = string
}
variable"db_name"{
    description = "Database name"
    type        = string
}  
variable"db_username"{
    description = "Database username"
    type        = string
}
variable"db_secret_arn"{
    description = "ARN of the Secrets Manager secret for DB password"
    type        = string
}
variable"db_secret_key_id"{
    description = "Key ID in the Secrets Manager secret for DB password"
    type        = string
}           
                