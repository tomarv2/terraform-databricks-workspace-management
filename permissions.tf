locals {
  job_id_list = values(databricks_job.databricks_new_cluster_job)[*].id != null ? values(databricks_job.databricks_new_cluster_job)[*].id : values(databricks_job.databricks_job)[*].id
}

# ------------------------------------------------
# Instance Pool Permissions
# ------------------------------------------------
resource "databricks_permissions" "worker_pool" {
  count = var.deploy_worker_instance_pool == true && var.instance_pool_access_control != null ? 1 : 0

  instance_pool_id = join("", databricks_instance_pool.worker_instance_nodes.*.id)

  dynamic "access_control" {
    for_each = var.instance_pool_access_control
    content {
      group_name       = access_control.value.group_name
      permission_level = access_control.value.permission_level
    }
  }
}

resource "databricks_permissions" "driver_pool" {
  count = var.deploy_driver_instance_pool == true && var.instance_pool_access_control != null ? 1 : 0

  instance_pool_id = join("", databricks_instance_pool.driver_instance_nodes.*.id)

  dynamic "access_control" {
    for_each = var.instance_pool_access_control
    content {
      group_name       = access_control.value.group_name
      permission_level = access_control.value.permission_level
    }
  }
}
# ------------------------------------------------
# Clusters Permissions
# ------------------------------------------------
resource "databricks_permissions" "cluster" {
  count = var.deploy_cluster == true && var.cluster_access_control != null ? 1 : 0

  cluster_id = var.fixed_value != 0 || var.auto_scaling != null ? join("", databricks_cluster.cluster.*.id) : join("", databricks_cluster.single_node_cluster.*.id)

  dynamic "access_control" {
    for_each = var.cluster_access_control
    content {
      group_name       = access_control.value.group_name
      permission_level = access_control.value.permission_level
    }
  }
}

# ------------------------------------------------
# Policy Permissions
# ------------------------------------------------
resource "databricks_permissions" "policy" {
  count = var.deploy_cluster_policy == true && var.policy_access_control != null ? 1 : 0

  cluster_policy_id = join("", databricks_cluster_policy.this.*.id)

  dynamic "access_control" {
    for_each = var.policy_access_control
    content {
      group_name       = access_control.value.group_name
      permission_level = access_control.value.permission_level
    }
  }
}
//
//# ------------------------------------------------
//# Jobs Permissions
//# ------------------------------------------------
//resource "databricks_permissions" "job" {
//  count = length(local.job_id_list)
//
//  job_id = local.job_id_list[count.index]
//
//  dynamic "access_control" {
//    for_each = var.job_access_control
//    content {
//      group_name       = "all users"
//      permission_level = "CAN_MANAGE"
//    }
//  }
//}

//# ------------------------------------------------
//# Notebooks Permissions
//# ------------------------------------------------
//resource "databricks_permissions" "notebook" {
//  #for_each = length(var.notebook_info) && var.job_access_control != null ? length(local.job_id_list) : 0
//  for_each = var.notebook_info
//
//  notebook_path = var.custom_path != "" ? var.custom_path : "${data.databricks_current_user.me.home}/${each.key}"
//
//  dynamic "access_control" {
//    for_each = var.notebook_access_control != null ? var.notebook_access_control : [] #var.notebook_access_control
//    content {
//      group_name       = access_control.value.group_name
//      permission_level = access_control.value.permission_level
//    }
//  }
//}
