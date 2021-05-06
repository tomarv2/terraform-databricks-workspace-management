module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git?ref=v0.0.4"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = "dapi123456789012"
  # ------------------------------------------------
  # ADMIN CONSOLE
  # ------------------------------------------------
  create_user = true
  # ------------------------------------------------
  # Notebook
  # ------------------------------------------------
  deploy_notebook     = true
  databricks_username = "vt@db.com"
  language            = "PYTHON"
  notebook_name       = "delme1"
  notebook_path       = "notebooks/sample.py"
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

