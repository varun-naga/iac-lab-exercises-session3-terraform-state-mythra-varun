output "db_address" {
  value = aws_db_instance.database.address
}

output "db_name" {
  value = aws_db_instance.database.db_name
}

output "db_username" {
  value = aws_db_instance.database.db_name
}
output "db_password_arn" {
  value=data.aws_secretsmanager_secret.db.arn
}
output "db_password" {
  value=data.aws_secretsmanager_secret_version.db
}
