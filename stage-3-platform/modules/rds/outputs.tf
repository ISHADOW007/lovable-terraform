############################################################
# Endpoint
############################################################

output "endpoint" {

  description = "RDS Endpoint"

  value = aws_db_instance.this.address

}

############################################################
# Port
############################################################

output "port" {

  value = aws_db_instance.this.port

}

############################################################
# Database Name
############################################################

output "database_name" {

  value = aws_db_instance.this.db_name

}

############################################################
# JDBC URL
############################################################

output "jdbc_url" {

  value = "jdbc:postgresql://${aws_db_instance.this.address}:${aws_db_instance.this.port}/${aws_db_instance.this.db_name}"

}

############################################################
# Username
############################################################

output "username" {

  value = aws_db_instance.this.username

  sensitive = true

}

############################################################
# Password
############################################################

output "password" {

  value = var.password

  sensitive = true

}

############################################################
# Security Group
############################################################

output "security_group_id" {

  value = aws_security_group.this.id

}

############################################################
# DB Subnet Group
############################################################

output "subnet_group" {

  value = aws_db_subnet_group.this.name

}