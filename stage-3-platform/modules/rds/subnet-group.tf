############################################################
# Security Group
############################################################

resource "aws_security_group" "this" {

  name = "${var.name}-rds"

  description = "PostgreSQL"

  vpc_id = var.vpc_id

  ingress {

    from_port = 5432

    to_port = 5432

    protocol = "tcp"

    security_groups = [

      var.eks_node_security_group_id

    ]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [

      "0.0.0.0/0"

    ]

  }

  tags = {

    Name = "${var.name}-rds"

  }

}