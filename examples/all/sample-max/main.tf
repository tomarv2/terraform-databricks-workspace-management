module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git?ref=v0.0.4"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = "dapi123456789012"
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster                  = true
  cluster_autotermination_minutes = 30
  cluster_min_workers             = 1
  cluster_max_workers             = 2
  # ------------------------------------------------
  # Cluster Policy
  # ------------------------------------------------
  cluster_policy_max_dbus_per_hour       = 5
  cluster_policy_autotermination_minutes = 5
  # ------------------------------------------------
  # Cluster Instance Pool
  # ------------------------------------------------
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
  deploy_job           = true
  use_existing_cluster = true
  num_workers          = 1
  email_notifications = [
    {
      on_failure                = ["varun.tomar@databricks.com"],
      no_alert_for_skipped_runs = true,
      on_start                  = ["varun.tomar@databricks.com"],
      on_success                = ["varun.tomar@databricks.com"]
    }
  ]
  # ------------------------------------------------
  # Notebook
  # ------------------------------------------------
  language      = "PYTHON"
  notebook_name = "delme"
  notebook_path = "notebooks/sample.py"
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
