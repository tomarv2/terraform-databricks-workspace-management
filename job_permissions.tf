locals {
  job_id_list = values(databricks_job.databricks_new_cluster_job)[*].id != null ? values(databricks_job.databricks_new_cluster_job)[*].id : values(databricks_job.databricks_job)[*].id
}

resource "databricks_permissions" "job" {
  count = local.user_name != "" ? length(local.job_id_list) : 0

  job_id = local.job_id_list[count.index]
  access_control {
    user_name        = join("", databricks_user.users.*.user_name)
    permission_level = "IS_OWNER"
  }
  access_control {
    group_name       = join("", databricks_group.spectators.*.display_name)
    permission_level = "CAN_MANAGE_RUN"
  }
}
