module "databricks_workspace_management" {
  source        = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # NOTEBOOK
  # ------------------------------------------------
  notebook_info = {
    default1 = {
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
    }
    default2 = {
      language   = "PYTHON"
      local_path = "notebooks/sample2.py"
    }
  }
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
