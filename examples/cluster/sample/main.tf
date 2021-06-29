module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
