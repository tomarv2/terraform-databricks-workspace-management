module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # Admin Console
  # ------------------------------------------------
  /*
  # NOTE: 2 options are available:
    - 1. "create_user": false -> no permissions are configured.
    - 2. "create_user", "databricks_username", "create_user", and "create_group" to create user and group.
    IMPORTANT: databricks_username should not pre-exist.
  */
  databricks_username = "demo@demo.com"
  create_user         = true
  create_group        = true
  # ------------------------------------------------
  aws_attributes = {
    instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/demo-role"
  }
  # ------------------------------------------------
  # Job
  # ------------------------------------------------
  deploy_job = true
  # NOTE: `deploy_cluster` or `use_existing_cluster` and `cluster_id` are required
  deploy_cluster = true
  #cluster_id = "1234-123456-lark123"
  num_workers               = 1
  retry_on_timeout          = false
  max_retries               = 3
  timeout                   = 30
  min_retry_interval_millis = 10
  max_concurrent_runs       = 1
  task_parameters = {
    "hello" = "world",
    "ping"  = "pong"
  }
  schedule = {
    cron_expression = "1 0 7 * * ?",
    timezone_id     = "America/Los_Angeles",
    pause_status    = "UNPAUSED"
  }
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
    default1 = {
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
    }
    default2 = {
      language   = "PYTHON"
      local_path = "notebooks/sample2.py"
    }
  }
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
