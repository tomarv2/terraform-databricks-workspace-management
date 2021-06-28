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
  # CLUSTER
  # ------------------------------------------------
  # NOTE:
  # Only one should be provided, either use `deploy_cluster` or provide existing `cluster_id`
  deploy_cluster = true
  # cluster_id                      = "0507-210128-assay460"
  cluster_autotermination_minutes = 30
  fixed_value                     = 1
  auto_scaling                    = [2, 3]
  # ------------------------------------------------
  # Cluster Policy
  # ------------------------------------------------
  cluster_policy_max_dbus_per_hour       = 5
  cluster_policy_autotermination_minutes = 15
  # ------------------------------------------------
  # Cluster Instance Pool
  # ------------------------------------------------
  deploy_instance_pool                  = false
  min_idle_instances                    = 1
  max_capacity                          = 2
  idle_instance_autotermination_minutes = 30
  # ------------------------------------------------
  # Cluster Worker Type
  # ------------------------------------------------
  local_disk    = 0
  min_cores     = 0
  gb_per_core   = 0
  min_gpus      = 0
  min_memory_gb = 0
  category      = "General purpose"
  # ------------------------------------------------
  # Job
  # ------------------------------------------------
  deploy_job  = true
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
    default1 = {
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
    }
    default2 = {
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
    }
  }
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
