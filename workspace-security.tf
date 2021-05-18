resource "databricks_secret_acl" "spectators" {
  count = var.databricks_username != null ? 1 : 0

  principal  = join("", databricks_group.spectators.*.display_name)
  scope      = "${var.teamid}-${var.prjid}"
  permission = "READ"

  #depends_on = [databricks_group.spectators, databricks_secret_scope.this]
}

resource "databricks_user" "users" {
  count = var.databricks_username != null ? 1 : 0

  user_name    = local.databricks_username
  display_name = local.databricks_displayname
}

resource "databricks_group" "spectators" {
  count = var.databricks_username != null ? 1 : 0

  display_name = "${var.teamid}-${var.prjid} (by ${data.databricks_current_user.me.alphanumeric})"
}

resource "databricks_group_member" "group_members" {
  count = var.databricks_username != null ? 1 : 0

  group_id  = join("", databricks_group.spectators.*.id)
  member_id = join("", databricks_user.users.*.id)
}
