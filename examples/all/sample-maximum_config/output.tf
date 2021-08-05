output "cluster_id" {
  description = "databricks cluster id"
  value       = module.databricks_workspace_management.cluster_id
}

output "databricks_job_url" {
  description = "databricks job url"
  value       = module.databricks_workspace_management.job_url
}

output "databricks_notebook_url" {
  description = "databricks notebook url"
  value       = module.databricks_workspace_management.notebook_url
}

output "job_new_cluster_url" {
  description = "databricks new cluster job url"
  value       = module.databricks_workspace_management.job_new_cluster_url
}

output "databricks_secret_acl" {
  description = "databricks secret acl"
  value       = module.databricks_workspace_management.databricks_secret_acl
}

output "databricks_group" {
  description = "databricks group name"
  value       = module.databricks_workspace_management.databricks_group
}

output "databricks_user" {
  description = "databricks user name"
  value       = module.databricks_workspace_management.databricks_user
}

output "databricks_user_id" {
  description = "databricks user id"
  value       = module.databricks_workspace_management.databricks_user_id
}

output "databricks_group_member" {
  description = "databricks group members"
  value       = module.databricks_workspace_management.databricks_group_member
}

output "notebook_permissions" {
  description = "databricks notebook permissions"
  value       = module.databricks_workspace_management.notebook_permissions
}

output "job_permissions" {
  description = "databricks job permissions"
  value       = module.databricks_workspace_management.job_permissions
}

output "cluster_permissions" {
  description = "databricks cluster permissions"
  value       = module.databricks_workspace_management.cluster_permissions
}

output "cluster_policy_permissions" {
  description = "databricks cluster policy permissions"
  value       = module.databricks_workspace_management.cluster_policy_permissions
}

output "driver_pool_permissions" {
  description = "databricks driver pool permissions"
  value       = module.databricks_workspace_management.driver_pool_permissions
}

output "worker_pool_permissions" {
  description = "databricks worker pool permissions"
  value       = module.databricks_workspace_management.driver_pool_permissions
}
