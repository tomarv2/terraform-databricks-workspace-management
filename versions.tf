provider "databricks" {
  host  = var.workspace_url #module.ai.databricks_host
  token = var.dapi_token    #module.ai.databricks_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.1"
    }
  }
}

data "databricks_current_user" "me" {}
data "databricks_spark_version" "latest" {}
data "databricks_node_type" "smallest" {
  local_disk = true
}