module "rds" {
  source                = "./modules/rds/"
  prefix                = var.prefix
  db_name               = var.db_name
  db_username           = var.db_username
  vpc_id            =     module.vpc.vpc_id
  ecs_security_group_id = module.ecs.ecs_security_group_id
  intra_subnet_ids      = module.vpc.intra_subnets
  #db_secret_arn    = aws_secretsmanager_secret.db.arn
  #db_secret_key_id = aws_secretsmanager_secret_version.db.secret_id
  #    db_address            = module.aws_db_instance.database.address
  #   db_name               = module.rds.aws_db_instance.database.db_name
  #   db_username           = aws_db_instance.database.username
  #   db_secret_arn         = data.aws_secretsmanager_secret.db.arn
  #   db_secret_key_id      = data.aws_secretsmanager_secret_version.db.secret_id
}