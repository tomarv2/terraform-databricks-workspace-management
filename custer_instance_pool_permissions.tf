resource "databricks_permissions" "pool" {
  instance_pool_id = databricks_instance_pool.instance_nodes.id
  access_control {
    group_name       = databricks_group.spectators.display_name
    permission_level = "CAN_ATTACH_TO"
  }
}
