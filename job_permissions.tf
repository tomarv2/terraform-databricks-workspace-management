/*
resource "databricks_permissions" "job" {
  job_id = local.databricks_job

  access_control {
    user_name        = databricks_user.users.user_name
    permission_level = "IS_OWNER"
  }
  access_control {
    group_name       = databricks_group.spectators.display_name
    permission_level = "CAN_MANAGE_RUN"
  }
}
*/
