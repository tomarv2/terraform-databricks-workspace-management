module "databricks_workspace_management" {
  source        = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # Admin Console
  # ------------------------------------------------
  /*
  # NOTE: If `databricks_username` is not provided, no permissions are configured
  databricks_username = "varun.tomar@databricks.com"
  # ------------------------------------------------
  # NOTE: Power User does not have permissions to configure instance profile
  aws_attributes = {
    instance_profile_arn = "arn:aws:iam::755921336062:instance-profile/security-tines-ecs-mgmt-role"
  }
  */
  # ------------------------------------------------
  # Job
  # ------------------------------------------------
  deploy_job = true
  # NOTE: `deploy_cluster` or `use_existing_cluster` and `cluster_id` are required
  deploy_cluster = true
  #cluster_id = "1234-123456-lark123"
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
