provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.47"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.5"
    }
  }
}

data "databricks_current_user" "me" {}

data "databricks_spark_version" "latest" {
  gpu = var.gpu
  ml  = var.ml
}
