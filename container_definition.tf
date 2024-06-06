locals {
  container_definition = jsonencode([
    {
      name      = "tsrecorder"
      image     = "tailscale/tsrecorder:${var.recorder_version}"
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      environment = [{
        "name" : "TSRECORDER_DST",
        "value" : "s3://s3.${data.aws_region.current.name}.amazonaws.com"
        }, {
        "name" : "TS_AUTH_KEY",
        "value" : var.tailscale_auth_key
        }, {
        "name" : "TSRECORDER_BUCKET",
        "value" : var.s3_bucket_name
      }]
      command = ["/tsrecorder", "--statedir=/data/state", "--ui"]
      logConfiguration = {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : aws_cloudwatch_log_group.tailscale.name,
          "awslogs-region" : data.aws_region.current.name,
          "awslogs-stream-prefix" : "tsrecorder"
        }
      },
      linux_parameters = {
        "initProcessEnabled" : true
        "capabilities" : {
          "add" : ["NET_ADMIN"]
        }
      }
    }
  ])
}
