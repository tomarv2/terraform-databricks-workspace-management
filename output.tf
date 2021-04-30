output "databricks_host" {
  description = "databricks cluster id"
  value       = databricks_cluster.this.id
}

output "databricks_token" {
  description = "databricks token"
  value       = databricks_token.pat.id
  sensitive   = true
}

output "notebook_url" {
  description = "databricks notebook url"
  value       = databricks_notebook.notebook_file.url
}

output "job_url" {
  description = "databricks job url"
  value       = databricks_job.this.url
}


/*
// workspace security
output "databricks_secret_acl" {
  value = databricks_secret_acl.spectators.principal
}

output "databricks_group" {
  value = databricks_group.spectators.display_name
}

output "databricks_user" {
  value = databricks_user.users.display_name
}

output "databricks_group_member" {
  value = databricks_group_member.group_members.group_id
}

output "databricks_permissions_notebook" {
  value = databricks_permissions.notebook.notebook_path
}

output "databricks_permissions_job" {
  value = databricks_permissions.job.id
}

output "databricks_permissions_cluster" {
  value = databricks_permissions.cluster.id
}

output "databricks_permissions_policy" {
  value = databricks_permissions.policy.id
}

output "databricks_permissions_pool" {
  value = databricks_permissions.pool.id
}
*/
