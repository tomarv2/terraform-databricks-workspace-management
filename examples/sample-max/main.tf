module "databricks_workspace_management" {
  source = "../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = "dapi123456789012"
  # ------------------------------------------------
  # Instance Pool
  # ------------------------------------------------
  min_idle_instances                    = 1
  max_capacity                          = 2
  idle_instance_autotermination_minutes = 30
  # ------------------------------------------------
  # Cluster
  # ------------------------------------------------
  cluster_autotermination_minutes        = 30
  cluster_min_workers                    = 1
  cluster_max_workers                    = 2
  cluster_policy_max_dbus_per_hour       = 5
  cluster_policy_autotermination_minutes = 5
  # ------------------------------------------------
  # Job
  # ------------------------------------------------
  num_workers = 1
  # ------------------------------------------------
  # Notebook
  # ------------------------------------------------
  language      = "PYTHON"
  notebook_name = "demo"
  notebook_path = "notebooks/sample.py"
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
