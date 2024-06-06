variable "name" {
  type        = string
  description = "A name for the Tailscale subnet router"
}

variable "cpu" {
  type        = number
  default     = 256
  description = "The CPU value to assign to the container (vCPU)"
}

variable "recorder_version" {
  type        = string
  default     = "stable"
  description = "The version of the Tailscale session recorder to use"

}

variable "memory" {
  type        = number
  default     = 512
  description = "The memory value to assign to the container (MiB)"
}

variable "assign_public_ip" {
  type        = bool
  default     = false
  description = "Whether to assign a public IP to the container"
}

variable "cpu_architecture" {
  type        = string
  default     = "X86_64"
  description = "The CPU architecture to use for the container. Either X86_64 or ARM64."
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs to use for the ECS task"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to use for the ECS task"
}

variable "ecs_cluster_id" {
  type        = string
  description = "The ID of the ECS cluster"
}

variable "tailscale_auth_key" {
  type        = string
  description = "The auth key for the session recorder"
}
variable "cloudwatch_retention_days" {
  type        = number
  description = "The number of days to retain logs in CloudWatch"
  default     = 7
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
  default     = {}
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to use for storing recordings"
}