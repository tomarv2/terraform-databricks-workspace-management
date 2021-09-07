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
  # NOTEBOOK
  # ------------------------------------------------
  notebooks = [
    {
      name       = "demo_notebook1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    },
    {
      name       = "demo_notebook2"
      local_path = "notebooks/sample2.py"
    }
  ]
  # ------------------------------------------------
  # NOTEBOOK ACCESS CONTROL
  # ------------------------------------------------
  notebook_access_control = [
    {
      group_name       = "demo"
      permission_level = "CAN_READ"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
