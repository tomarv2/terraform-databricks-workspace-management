provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 0.5.7"
    }
  }
}


module "databricks_workspace_management" {
  source = "../../../"
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  fixed_value    = 1
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
      group_name       = "demo"
      permission_level = "CAN_ATTACH_TO"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
