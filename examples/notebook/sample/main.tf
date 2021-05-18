module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git?ref=v0.0.5"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token = var.dapi_token
  # ------------------------------------------------
  # NOTEBOOK
  # ------------------------------------------------
  notebook_info = {
    default994 = {
      language   = "PYTHON"
      local_path = "notebooks/sample.py"
    }
    default140 = {
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
    }
    default241 = {
      language   = "PYTHON"
      local_path = "notebooks/sample.py"
    }
  }
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
