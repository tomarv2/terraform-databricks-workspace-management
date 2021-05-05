resource "databricks_permissions" "cluster" {
  cluster_id = join("", databricks_cluster.cluster.*.id)
  access_control {
    user_name        = databricks_user.users.user_name
    permission_level = "CAN_RESTART"
  }
  access_control {
    group_name       = databricks_group.spectators.display_name
    permission_level = "CAN_ATTACH_TO"
  }
}

resource "databricks_permissions" "policy" {
  cluster_policy_id = databricks_cluster_policy.this.id
  access_control {
    group_name       = databricks_group.spectators.display_name
    permission_level = "CAN_USE"
  }
}
