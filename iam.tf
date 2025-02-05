data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "exec_role" {
  name               = "ecs-task-execution-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "exec_policy" {
  role       = aws_iam_role.exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_tailscale" {
  name               = "ecs-task-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

data "aws_iam_policy_document" "ecs_task_logs_tailscale" {
  statement {
    effect    = "Allow"
    actions   = ["logs:DescribeLogGroups"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]
    resources = [
      aws_cloudwatch_log_group.tailscale.arn,
    ]
  }
}

resource "aws_iam_policy" "ecs_task_logs_tailscale" {
  name        = "ecs-task-logs-${var.name}"
  description = "Permissions for ECS task to write logs for Tailscale session recorder"
  policy      = data.aws_iam_policy_document.ecs_task_logs_tailscale.json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_logs_tailscale" {
  role       = aws_iam_role.ecs_task_tailscale.name
  policy_arn = aws_iam_policy.ecs_task_logs_tailscale.arn
}


resource "aws_iam_role" "task_role" {
  name               = "ecs-task-role-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
  tags               = var.tags
}

data "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
    ]
    effect = "Allow"
    resources = [
      data.aws_s3_bucket.bucket.arn,
      "${data.aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy-${var.name}"
  description = "Permissions for ECS task to write to S3"
  policy      = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_iam_role_policy_attachment" "s3_policy" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
