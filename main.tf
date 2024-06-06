data "aws_region" "current" {}

resource "aws_security_group" "tailscale" {
  name        = "tailscale"
  description = "Security group for tailscale session recorder"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_ecs_service" "tailscale" {
  name                  = var.name
  cluster               = var.ecs_cluster_id
  task_definition       = aws_ecs_task_definition.tailscale.arn
  desired_count         = 1
  wait_for_steady_state = true
  launch_type           = "FARGATE"

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = [aws_security_group.tailscale.id]
    subnets          = var.subnet_ids
  }
}

resource "aws_ecs_task_definition" "tailscale" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.exec_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  container_definitions = local.container_definition


  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.cpu_architecture
  }

  tags = var.tags
}
