module "databricks_workspace_management" {
  source = "../../"

  workspace_url = "https://workspace-0tg.cloud.sample.com"
  dapi_token    = "dapi1234567890"
  notebook_path = "notebooks/sample.py"
  notebook_name = "sec-test"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

