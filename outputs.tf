output "website_url" {
  description = "The website URL."
  value       = format("http://%s/users", aws_lb.lb.dns_name)
}
output "vpc_id" {
  description = "The VPC ID."
  value       = module.vpc.vpc_id
}
output "intra_subnet_ids" {
  description = "The intra subnet IDs."
  value       = module.vpc.intra_subnets
}

