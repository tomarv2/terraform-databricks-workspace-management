resource "databricks_permissions" "cluster" {
  count = var.deploy_cluster == true && (var.databricks_username != null) ? 1 : 0

  cluster_id = var.fixed_value != 0 || var.auto_scaling != null ? join("", databricks_cluster.cluster.*.id) : join("", databricks_cluster.single_node_cluster.*.id)

  access_control {
    user_name        = var.databricks_username != null ? var.databricks_username: join("", databricks_user.users.*.user_name)
    permission_level = "CAN_RESTART"
  }
  access_control {
    group_name       = join("", databricks_group.spectators.*.display_name)
    permission_level = "CAN_ATTACH_TO"
  }
}

resource "databricks_permissions" "policy" {
  count = var.deploy_cluster == true && (var.databricks_username != null) ? 1 : 0

  cluster_policy_id = join("", databricks_cluster_policy.this.*.id)
  access_control {
    group_name       = join("",databricks_group.spectators.*.display_name)
    permission_level = "CAN_USE"
  }
}
