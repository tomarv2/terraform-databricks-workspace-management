module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git?ref=v0.0.4"

  workspace_url = "https://<workspace_url>.cloud.sample.com"
  dapi_token    = "dapi1234567890"

  create_group    = true
  deploy_cluster  = true
  deploy_job      = true
  deploy_notebook = true
  notebook_path   = "notebooks/sample.py"
  notebook_name   = "delme"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
