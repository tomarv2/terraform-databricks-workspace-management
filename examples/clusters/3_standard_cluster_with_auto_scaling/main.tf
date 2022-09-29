provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.3.1"
    }
  }
}


module "cluster" {
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
