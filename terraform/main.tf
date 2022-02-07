provider "aws" {
  region = var.region
}

terraform {
  cloud {
    organization = "setup-graph"

    workspaces {
      tags = ["all"]
    }
  }
}

# A resource group is an optional, but very nice thing to have, especially
# when managing resources across CF + TF + SLS.
#
# This RG aggregates all of CF + TF + SLS together by `Service` + `Stage`.
resource "aws_resourcegroups_group" "resources_stage" {
  name = "tf-${local.service_name}-${var.stage}"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "Service",
      "Values": ["${local.service_name}"]
    },
    {
      "Key": "Stage",
      "Values": ["${var.stage}"]
    }
  ]
}
JSON

  }
}


###############################################################################
# Base `serverless` IAM support
###############################################################################
module "serverless" {
  source  = "FormidableLabs/serverless/aws"
  version = "1.0.0"

  region       = var.region
  service_name = local.service_name
  stage        = var.stage
  # OPTION(custom_role): override the Lambda execution role that
  # terraform-aws-serverless creates by default.
  # lambda_role_name = "${aws_iam_role.lambda_execution_custom.name}"

  # (Default values)
  # iam_region          = `*`
  # iam_partition       = `*`
  # iam_account_id      = `AWS_CALLER account`
  # tf_service_name     = `tf-SERVICE_NAME`
  # sls_service_name    = `sls-SERVICE_NAME`
  # role_admin_name     = `admin`
  # role_developer_name = `developer`
  # role_ci_name        = `ci`
  # opt_many_lambdas    = false
}
