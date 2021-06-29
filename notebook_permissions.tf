resource "databricks_permissions" "notebook" {
  for_each = local.user_name != "" ? var.notebook_info : {}

  notebook_path = "${data.databricks_current_user.me.home}/${each.key}"

  access_control {
    user_name        = local.user_name
    permission_level = "CAN_RUN"
  }
  access_control {
    group_name       = join("", databricks_group.spectators.*.display_name)
    permission_level = "CAN_READ"
  }
}
