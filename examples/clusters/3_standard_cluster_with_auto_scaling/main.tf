provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.5"
    }
  }
}


module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = var.workspace_url
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  auto_scaling   = [1, 3]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
