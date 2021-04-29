module "databricks_workspace_management" {
  source = "../../"

  workspace_url = "https://<workspace_url>.cloud.sample.com"
  dapi_token    = "dapi1234567890"
  notebook_path = "notebooks/sample.py"
  notebook_name = "demo"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

