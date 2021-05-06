module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git?ref=v0.0.4"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = "dapi123456789012"
  # ------------------------------------------------
  # ADMIN CONSOLE
  # ------------------------------------------------
  create_user = true
  # ------------------------------------------------
  # Job
  # ------------------------------------------------
  deploy_job = true
  # NOTE: `deploy_cluster` or `use_existing_cluster` and `existing_cluster_id` are required
  deploy_cluster       = true
  use_existing_cluster = false
  #existing_cluster_id = "1234-123456-lark123"
  num_workers = 1
  email_notifications = {
    on_failure                = ["demo@demo.com"],
    no_alert_for_skipped_runs = true,
    on_start                  = ["demo@demo.com"],
    on_success                = ["demo@demo.com"]
  }
  # ------------------------------------------------
  # Notebook
  # ------------------------------------------------
  deploy_notebook = true
  language        = "PYTHON"
  notebook_name   = "delme"
  notebook_path   = "notebooks/sample.py"
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
