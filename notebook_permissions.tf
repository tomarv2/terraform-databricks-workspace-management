resource "databricks_permissions" "notebook" {
  notebook_path = local.notebook
  access_control {
    user_name        = databricks_user.users.user_name
    permission_level = "CAN_RUN"
  }
  access_control {
    group_name       = databricks_group.spectators.display_name
    permission_level = "CAN_READ"
  }
}
