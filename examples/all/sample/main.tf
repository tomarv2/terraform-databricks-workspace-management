module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git"

  workspace_url = "https://<workspace_url>.cloud.sample.com"
  dapi_token    = "dapi1234567890"
  # ------------------------------------------------
  # Admin Console
  # ------------------------------------------------
  # NOTE:
  # - If `create_group` is `true`, `create_user` should be set to `true`
  # - If `databricks_username` is not provided,
  # `create_user` will use the current DB login name and add `@example.com` to generate databricks_username
  databricks_username = "demo@demo.com"
  # ------------------------------------------------
  deploy_cluster  = true
  deploy_job      = true
  notebook_info = {
    default994 = {
    language        = "PYTHON"
    local_path     = "notebooks/sample.py"
    }
    default140 = {
      language        = "PYTHON"
      local_path            = "notebooks/sample1.py"
    }
    default241 = {
      language        = "PYTHON"
      local_path            = "notebooks/sample.py"
    }
  }
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
