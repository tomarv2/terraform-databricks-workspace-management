resource "databricks_secret_acl" "spectators" {
  principal  = databricks_group.spectators.display_name
  scope      = databricks_secret_scope.this.name
  permission = "READ"
}

resource "databricks_group" "spectators" {
  display_name = "${var.teamid}-${var.prjid} (by ${data.databricks_current_user.me.alphanumeric})"
}

resource "databricks_user" "users" {
  user_name    = local.databricks_username
  display_name = "${var.teamid}-${var.prjid} ${data.databricks_current_user.me.alphanumeric}"
}

resource "databricks_group_member" "group_members" {
  group_id  = databricks_group.spectators.id
  member_id = databricks_user.users.id
}
