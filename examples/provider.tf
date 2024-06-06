provider "aws" {
  region = "us-west-2"
}

provider "tailscale" {
  api_key = var.tailscale_api_key
}
