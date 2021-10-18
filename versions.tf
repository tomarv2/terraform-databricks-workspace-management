terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = ">= 3.61"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = ">= 0.3.9"
    }
  }
}

data "databricks_current_user" "me" {}

data "databricks_spark_version" "latest" {
  gpu = var.gpu
  ml  = var.ml
}
