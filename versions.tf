provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      version = "~> 3.30"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.3"
    }
  }
}

data "databricks_current_user" "me" {}
data "databricks_spark_version" "latest" {}
data "databricks_node_type" "smallest" {
  local_disk = true
}
