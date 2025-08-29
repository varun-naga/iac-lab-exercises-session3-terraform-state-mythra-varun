module "ecs" {
  source                = "./modules/ecs/"
  prefix                = var.prefix
  region                = var.region
  vpc_cidr              = var.vpc_cidr
  vpc_id                = module.vpc.vpc_id
  lb_sg                 = aws_security_group.lb_sg.id
  private_subnet_ids    = module.vpc.private_subnets
  alb_security_group_id = aws_security_group.lb_sg.id
  alb_target_group_arn  = aws_lb_target_group.tg.arn
  db_address            = module.rds.db_address
  db_name               = module.rds.db_name
  db_username           = module.rds.db_username
  db_secret_arn         = module.rds.db_password_arn
  db_secret_key_id      = module.rds.db_password.secret_id
}
