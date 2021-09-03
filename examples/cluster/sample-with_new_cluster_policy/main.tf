provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.5"
    }
  }
}


module "databricks_workspace_management" {
  source = "../../../"

  workspace_url = "https://<workspace_url>.cloud.databricks.com"
  dapi_token    = var.dapi_token
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster                    = true
  cluster_autotermination_minutes   = 30
  fixed_value                       = 1
  auto_scaling                      = [2, 3]
  worker_node_type_id               = "i3.large"
  driver_node_type_id               = "i3.large"
  spark_version                     = "8.3.x-scala2.12"
  add_instance_profile_to_workspace = true

  aws_attributes = {
    instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/aws-instance-role"
  }
  # ------------------------------------------------
  # CLUSTER PERMISSIONS
  # ------------------------------------------------
  cluster_access_control = [
    {
      group_name       = "demo_group"
      permission_level = "CAN_RESTART"
    }
  ]
  # ------------------------------------------------
  # CLUSTER POLICY
  # ------------------------------------------------
  deploy_cluster_policy = true
  policy_overrides = {
    "dbus_per_hour" : {
      "type" : "range",
      "maxValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 30,
      "hidden" : true
    },
    "spark_conf.spark.databricks.io.cache.enabled" : {
      "value" : "true"
    },
  }
  # ------------------------------------------------
  # CLUSTER POLICY PERMISSIONS
  # ------------------------------------------------
  policy_access_control = [
    {
      group_name       = "demo_group"
      permission_level = "CAN_RESTART"
    }
  ]
  # ------------------------------------------------
  # INSTANCE POOL
  # ------------------------------------------------
  deploy_worker_instance_pool           = true
  min_idle_instances                    = 1
  max_capacity                          = 5
  idle_instance_autotermination_minutes = 30
  # ------------------------------------------------
  # INSTANCE POOL PERMISSIONS
  # ------------------------------------------------
  instance_pool_access_control = [
    {
      group_name       = "demo_group"
      permission_level = "CAN_ATTACH_TO"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
