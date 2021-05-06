module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git?ref=v0.0.5"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = "dapi123456789012"
  # ------------------------------------------------
  # Admin Console
  # ------------------------------------------------
  # NOTE:
  # - If `create_group` is `true`, `create_user` should be set to `true`
  # - If `databricks_username` is not provided,
  # `create_user` will use the current DB login name and add `@example.com` to generate databricks_username
  databricks_username = "demo@demo.com"
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
