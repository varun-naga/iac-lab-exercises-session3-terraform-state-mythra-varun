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
variable repo_name{
    type=string
    description="GitHub repository name"
    default= "varun-naga/iac-lab-exercises-session3-terraform-state-mythra-varun"
}
# variable "subnet1_cidr"{
#     type=string
#     description="Subnet 1 CIDR block"
# }
# variable "subnet2_cidr"{
#     type=string
#     description="Subnet 2 CIDR block"
# }
# variable "subnet3_cidr"{
#     type=string
#     description="Subnet 3 CIDR block"
# }
# variable "subnet4_cidr"{
#     type=string
#     description="Subnet 4 CIDR block"
# }
# variable "subnet5_cidr"{
#     type=string
#     description="Subnet 5 CIDR block"
# }
# variable "subnet6_cidr"{
#     type=string
#     description="Subnet 6 CIDR block"
# }