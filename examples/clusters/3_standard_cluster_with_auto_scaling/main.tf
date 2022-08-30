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
  deploy_cluster = true

  auto_scaling = [3, 5]

  custom_tags = {
    "Application" : "DemoApp"
  }
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
