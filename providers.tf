terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = ">= 4.14"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">= 0.5.7"
    }
  }
}

data "databricks_current_user" "me" {}

data "databricks_spark_version" "latest" {
  gpu = var.gpu
  ml  = var.ml
}
