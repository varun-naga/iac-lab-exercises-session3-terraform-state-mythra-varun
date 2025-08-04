variable "prefix"{
    description="prefix to the resources"
    type=string
}
variable "region"{
    type=string
    description="Region to deploy the resources"
}
variable "vpc_cidr"{
    type=string
    description = "VPC CIDR block"
}
variable "number_of_public_subnets"{
    description="Number of public subnets to create"
    type=number
    default=2
}
variable "number_of_private_subnets"{
    description="Number of private subnets to create"
    type=number
    default=2
}
variable "number_of_secure_subnets"{
    description="Number of secure subnets to create"
    type=number
    default=2
}
