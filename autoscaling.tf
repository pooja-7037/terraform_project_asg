module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  # Autoscaling group
  name = "example-asg"

  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = data.aws_subnet_ids.test_subnet_ids.ids

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  lt_name                = "example-asg"
  description            = "Launch template example"
  update_default_version = true

  use_lt    = true
  create_lt = true

  image_id          = data.aws_ami.ubuntu_20.id
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = false
  key_name          = var.ssh_key

  credit_specification = {
    cpu_credits = "standard"
  }

  target_group_arns = module.alb.target_group_arns
  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
}

# resource "aws_autoscaling_attachment" "asg_attachment_alb" {
#   depends_on = [
#     module.asg,
#     module.alb
#   ]
#    autoscaling_group_name = module.asg.autoscaling_group_id
#    alb_target_group_arn   = module.alb.target_group_arns
#  }