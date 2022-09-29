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


module "notebook" {
  source = "../../../"
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
  notebooks_access_control = [
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
