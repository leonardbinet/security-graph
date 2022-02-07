# Overview

Work in progress, using https://github.com/FormidableLabs/terraform-aws-serverless terraform module, and terraform cloud.


## Setup

### 1. AWS account

To provision ressources on AWS you need an account, and a user that will be used by terraform.

Create AWS IAM user with Administrator permissions in AMI control pannel in AWS console.
Then login to aws via command line using its API key/secret (requires `awscli`).
```
aws configure
```

### 2. Terraform Cloud

Terraform Cloud will be used to store terraform states.
Create an account and login via CLI (requires terraform ^0.1.13)

```
terraform login
```

### 3. Workspace integration with Github repository

Create a repository with you terraform configuration, and integrate workspace with it via terraform cloud website.
