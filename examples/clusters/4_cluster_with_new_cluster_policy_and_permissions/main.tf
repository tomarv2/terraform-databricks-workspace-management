provider "databricks" {
  host  = var.workspace_url
  token = var.dapi_token
}

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.3.1"
    }
  }
}

module "cluster" {
  source = "../../../"
  # ------------------------------------------------
  # CLUSTER
  # ------------------------------------------------
  deploy_cluster = true
  auto_scaling   = [2, 3]
  # ------------------------------------------------
  # CLUSTER PERMISSIONS
  # ------------------------------------------------
  cluster_access_control = [
    {
      group_name       = "demo"
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
      "type" : "fixed",
      "value" : "true"
    },
  }
  # ------------------------------------------------
  # CLUSTER POLICY PERMISSIONS
  # ------------------------------------------------
  policy_access_control = [
    {
      group_name       = "demo"
      permission_level = "CAN_USE"
    }
  ]
  # ------------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
