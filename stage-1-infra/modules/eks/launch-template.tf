resource "aws_launch_template" "workers" {

  name_prefix = "${var.cluster_name}-workers-"

  vpc_security_group_ids = [
    var.node_security_group_id
  ]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20
      volume_type = "gp2"
      delete_on_termination = true
      encrypted = true
    }
  }

  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = var.tags
  }
}