############################################################
# DB Subnet Group
############################################################

resource "aws_db_subnet_group" "this" {

  name = "${var.name}-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {

    Name = "${var.name}-subnet-group"

  }

}