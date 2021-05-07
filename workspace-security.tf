resource "databricks_secret_acl" "spectators" {
  principal  = databricks_group.spectators.display_name
  scope      = "${var.teamid}-${var.prjid}"
  permission = "READ"

  depends_on = [databricks_group.spectators, databricks_secret_scope.this]
}

resource "databricks_group" "spectators" {
  display_name = "${var.teamid}-${var.prjid} (by ${data.databricks_current_user.me.alphanumeric})"
}

resource "databricks_user" "users" {
  count = var.create_user ? 1 : 0

  user_name    = local.databricks_username
  display_name = local.databricks_displayname
}

resource "databricks_group_member" "group_members" {
  count = var.create_group ? 1 : 0

  group_id  = databricks_group.spectators.id
  member_id = join("", databricks_user.users.*.id)
}
