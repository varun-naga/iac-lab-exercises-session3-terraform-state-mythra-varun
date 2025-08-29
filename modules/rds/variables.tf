variable"db_name"{
    description = "Database name"
    type        = string
}  
variable"db_username"{
    description = "Database username"
    type        = string
}
variable "prefix" {
  description = "prefix to the resources"
  type        = string
}
variable "ecs_security_group_id" {
  description = "Security group ID of the ECS service"
  type        = string
}
variable "intra_subnet_ids" {
  //type = list(string)
}
variable "vpc_id" {

}