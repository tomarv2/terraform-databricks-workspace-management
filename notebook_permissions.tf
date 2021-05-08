resource "databricks_permissions" "notebook" {
  for_each = var.notebook_info

  notebook_path = "${data.databricks_current_user.me.home}/${each.key}"

  access_control {
    user_name        = var.create_user == true ? join("", databricks_user.users.*.user_name) : local.databricks_username
    permission_level = "CAN_RUN"
  }
  access_control {
    group_name       = join("", databricks_group.spectators.*.display_name)
    permission_level = "CAN_READ"
  }
}
