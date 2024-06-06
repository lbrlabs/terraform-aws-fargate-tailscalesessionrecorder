variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "tailscale_api_key" {
  description = "The Tailscale api key"
  type        = string
  sensitive   = true
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}
