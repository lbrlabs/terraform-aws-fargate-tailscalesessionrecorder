data "aws_ecs_cluster" "main" {
  cluster_name = var.ecs_cluster_id
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    SubnetType = "Private"
  }
}

resource "aws_s3_bucket" "session-recordings" {
  bucket = "lbr-session-recordings"
}

resource "aws_s3_bucket_ownership_controls" "session-recordings" {
  bucket = aws_s3_bucket.session-recordings.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "tailscale_tailnet_key" "session-recorder" {
  description   = "Used by tailscale session recorder"
  preauthorized = true
  reusable      = true
  ephemeral     = true
  tags          = ["tag:session-recorder"]

}



module "sessionrecorder" {
  source             = "../"
  name               = "lbr-fargate-sessionrecorder"
  subnet_ids         = data.aws_subnets.private.ids
  ecs_cluster_id     = data.aws_ecs_cluster.main.id
  s3_bucket_name     = aws_s3_bucket.session-recordings.bucket
  tailscale_auth_key = resource.tailscale_tailnet_key.session-recorder.key
  vpc_id             = var.vpc_id
  recorder_version   = "unstable"
  depends_on         = [aws_s3_bucket.session-recordings, aws_s3_bucket_ownership_controls.session-recordings]
}
