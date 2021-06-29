locals {
  job_id_list = values(databricks_job.databricks_new_cluster_job)[*].id != null ? values(databricks_job.databricks_new_cluster_job)[*].id : values(databricks_job.databricks_job)[*].id
  user_name   = var.databricks_username != "" ? var.databricks_username : join("", databricks_user.users.*.id)
  #group_name = var.databricks_groupname != "" ? var.databricks_groupname : join("",  databricks_group.this.*.display_name)
}

# ------------------------------------------------
# Instance Pool Permissions
# ------------------------------------------------
resource "databricks_permissions" "pool" {
  count = var.deploy_instance_pool == true && local.user_name != "" ? 1 : 0

  instance_pool_id = join("", databricks_instance_pool.instance_nodes.*.id)
  access_control {
    group_name       = var.databricks_groupname != "" ? var.databricks_groupname : join("", databricks_group.this.*.display_name)
    permission_level = "CAN_ATTACH_TO"
  }
}

# ------------------------------------------------
# Clusters Permissions
# ------------------------------------------------
resource "databricks_permissions" "cluster" {
  count = var.deploy_cluster == true && var.create_user != false ? 1 : 0

  cluster_id = var.fixed_value != 0 || var.auto_scaling != null ? join("", databricks_cluster.cluster.*.id) : join("", databricks_cluster.single_node_cluster.*.id)
  access_control {
    user_name        = local.databricks_username
    permission_level = "CAN_RESTART"
  }
  access_control {
    group_name       = join("", databricks_group.this.*.display_name)
    permission_level = "CAN_ATTACH_TO"
  }
}

resource "databricks_permissions" "policy" {
  count = var.deploy_cluster == true && var.create_group != false ? 1 : 0

  cluster_policy_id = join("", databricks_cluster_policy.this.*.id)
  access_control {
    group_name       = join("", databricks_group.this.*.display_name)
    permission_level = "CAN_USE"
  }
}

# ------------------------------------------------
# Jobs Permissions
# ------------------------------------------------
resource "databricks_permissions" "job" {
  count = local.user_name != "" ? length(local.job_id_list) : 0

  job_id = local.job_id_list[count.index]
  access_control {
    user_name        = local.databricks_username
    permission_level = "IS_OWNER"
  }
  access_control {
    group_name       = var.create_group != false ? join("", databricks_group.this.*.display_name) : var.databricks_groupname
    permission_level = "CAN_MANAGE_RUN"
  }
}

# ------------------------------------------------
# Notebooks Permissions
# ------------------------------------------------
resource "databricks_permissions" "notebook" {
  for_each = local.user_name != "" ? var.notebook_info : {}

  notebook_path = "${data.databricks_current_user.me.home}/${each.key}"

  access_control {
    user_name        = var.create_user != false ? join("", databricks_user.users.*.user_name) : var.databricks_username
    permission_level = "CAN_RUN"
  }
  access_control {
    group_name       = var.create_group != false ? join("", databricks_group.this.*.display_name) : var.databricks_groupname
    permission_level = "CAN_READ"
  }
}
