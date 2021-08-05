module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = "https://<workspace_url>.cloud.sample.com"
  dapi_token    = "dapi1234567890"
  # ------------------------------------------------
  # Admin Console
  # ------------------------------------------------
  /*
  # NOTE: 2 options are available:
    - No `create_user`: no permissions are configured.
    - `databricks_username`, `create_user`, and `create_group` to create user(user should not be existing already) and group.
    - Provide `create_user` and `databricks_username`
  */
  databricks_username = "demo@demo.com"
  create_user         = true
  create_group        = true
  /*
  # ------------------------------------------------
  aws_attributes = {
    instance_profile_arn = "arn:aws:iam::755921336062:instance-profile/security-tines-ecs-mgmt-role"
  }
  */
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
  worker_node_type_id             = "i3.large"
  driver_node_type_id             = "i3.large"
  spark_version                   = "8.3.x-scala2.12"
  spark_conf = {
    "spark.databricks.io.cache.enabled" = true
    "spark.driver.maxResultSize"        = "100g"
  }
  # ------------------------------------------------
  # Cluster Policy
  # ------------------------------------------------
  policy_overrides = {
    "spark_conf.spark.databricks.io.cache.enabled" : {
      "value" : "true"
    },
  }
  # ------------------------------------------------
  # Cluster Instance Pool
  # ------------------------------------------------
  deploy_worker_instance_pool           = false
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
