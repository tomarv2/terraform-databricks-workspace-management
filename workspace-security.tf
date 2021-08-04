resource "databricks_secret_acl" "spectators" {
  count = var.databricks_username != "" && var.create_group != false ? 1 : 0

  principal  = join("", databricks_group.this.*.display_name)
  scope      = "${var.teamid}-${var.prjid}"
  permission = "READ"

  #depends_on = [databricks_secret_scope.this]
}

resource "databricks_user" "users" {
  count = var.databricks_username != "" && var.create_user != false ? 1 : 0

  user_name    = local.databricks_username
  display_name = local.databricks_displayname
}

resource "databricks_group" "this" {
  count = var.create_group != false ? 1 : 0

  display_name               = "${var.teamid}-${var.prjid} (Terraform managed)"
  allow_cluster_create       = var.allow_cluster_create
  allow_instance_pool_create = var.allow_instance_pool_create
  allow_sql_analytics_access = var.allow_sql_analytics_access
}

resource "databricks_group_member" "group_members" {
  count = var.create_user != false && var.create_group != false ? 1 : 0

  group_id  = join("", databricks_group.this.*.id)
  member_id = join("", databricks_user.users.*.id)
}
