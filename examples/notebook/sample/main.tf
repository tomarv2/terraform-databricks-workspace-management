module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # NOTEBOOK
  # ------------------------------------------------
  local_notebook_info = [
    {
      name       = "local_demo_job1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    },
    {
      name       = "local_demo_job2"
      local_path = "notebooks/sample2.py"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
