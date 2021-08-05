output "cluster_id" {
  description = "databricks cluster id"
  value       = join("", databricks_cluster.cluster.*.id)
}

/*
output "databricks_token" {
  description = "databricks token"
  value       = databricks_token.pat.*.token_value
 sensitive   = true
}
*/

output "notebook_url" {
  description = "databricks notebook url"
  value       = { for k, v in databricks_notebook.notebook_file : k => v.url }
}

output "job_url" {
  description = "databricks job url"
  value       = { for k, v in databricks_job.databricks_job : k => v.url }
}

output "job_new_cluster_url" {
  description = "databricks new cluster job url"
  value       = { for k, v in databricks_job.databricks_new_cluster_job : k => v.url }
}

output "job_id" {
  description = "databricks job id"
  value       = { for k, v in databricks_job.databricks_job : k => v.id }
}

output "job_new_cluster_id" {
  description = "databricks new cluster job id"
  value       = { for k, v in databricks_job.databricks_new_cluster_job : k => v.id }
}

output "databricks_secret_acl" {
  description = "databricks secret acl"
  value       = join("", databricks_secret_acl.spectators.*.principal)
}

output "databricks_group" {
  description = "databricks group name"
  value       = join("", databricks_group.this.*.display_name)
}

output "databricks_user" {
  description = "databricks user name"
  value       = join("", databricks_user.users.*.display_name)
}

output "databricks_user_id" {
  description = "databricks user id"
  value       = join("", databricks_user.users.*.id)
}

output "databricks_group_member" {
  description = "databricks group members"
  value       = join("", databricks_group_member.group_members.*.group_id)
}

/*
output "databricks_permissions_job" {
  value = databricks_permissions.
}
*/

//output "databricks_permissions_cluster_group_can_attach_to" {
//  description = "databricks cluster permissions group can attach to"
//  value       = join("", databricks_permissions.group_can_attach_to.*.id)
//}

output "databricks_permissions_cluster_group_can_attach_to" {
  description = "databricks cluster permissions group can attach to"
  value       = join("", databricks_permissions.cluster.*.id)
}

output "databricks_permissions_policy" {
  description = "databricks cluster policy"
  value       = join("", databricks_permissions.policy.*.id)
}

//output "databricks_permissions_pool" {
//  description = "databricks instance pool permissions"
//  value       = join("", databricks_permissions.pool.*.id)
//}
