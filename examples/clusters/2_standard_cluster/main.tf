provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 0.5.7"
    }
  }
}


module "databricks_workspace_management" {
  source = "../../../"
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster                  = true
  fixed_value                     = 1
  cluster_autotermination_minutes = 30
  worker_node_type_id             = "Standard_DS3_v2"
  driver_node_type_id             = "Standard_DS3_v2"
  spark_version                   = "8.3.x-scala2.12"
  spark_conf = {
    "spark.databricks.io.cache.enabled" = true
    "spark.driver.maxResultSize"        = "20g"
  }
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
