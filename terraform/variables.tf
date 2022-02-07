variable "region" {
  description = "The deploy target region in AWS"
  default     = "eu-west-3"
}

variable "stage" {
  description = "The stage/environment to deploy to. Suggest: `sandbox`, `development`, `staging`, `production`."
  default     = "sandbox"
}

locals {
  service_name = "security-graph"
}

locals {
  tags = {
    "Service" = local.service_name
    "Stage"   = var.stage
  }
}

