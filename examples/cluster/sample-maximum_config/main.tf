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
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster                  = true
  cluster_autotermination_minutes = 30
  fixed_value                     = 1
  auto_scaling                    = [2, 3]
  node_type_id                    = "i3.large"
  driver_node_type_id             = "i3.large"
  spark_version                   = "8.3.x-scala2.12"
  spark_conf = {
    "spark.databricks.io.cache.enabled" = true
    "spark.driver.maxResultSize"        = "100g"
  }
  # ------------------------------------------------
  # Cluster Instance Pool
  # ------------------------------------------------
  deploy_worker_instance_pool           = false
  min_idle_instances                    = 1
  max_capacity                          = 5
  idle_instance_autotermination_minutes = 30
  # ------------------------------------------------
  # Cluster Policy
  # ------------------------------------------------
  policy_overrides = {
    "spark_conf.spark.databricks.io.cache.enabled" : {
      "value" : "true"
    },
  }
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
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
