resource "databricks_permissions" "pool" {
  count = var.deploy_instance_pool ? 1 : 0

  instance_pool_id = join("", databricks_instance_pool.instance_nodes.*.id)
  access_control {
    group_name       = databricks_group.spectators.display_name
    permission_level = "CAN_ATTACH_TO"
  }
}
