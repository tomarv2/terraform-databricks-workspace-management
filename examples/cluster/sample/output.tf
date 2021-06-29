output "cluster_id" {
  description = "databricks cluster id"
  value       = module.databricks_workspace_management.cluster_id
}

output "databricks_token" {
  description = "databricks token"
  value       = module.databricks_workspace_management.databricks_token
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
/*
output "databricks_permissions_notebook" {
  description = "databricks notebook permissions"
  value       = module.databricks_workspace_management.databricks_permissions_notebook
}

output "databricks_permissions_job" {
  value = module.databricks_workspace_management.databricks_permissions_job
}
*/

output "databricks_permissions_cluster" {
  description = "databricks cluster permissions"
  value       = module.databricks_workspace_management.databricks_permissions_cluster
}

output "databricks_permissions_policy" {
  description = "databricks cluster policy"
  value       = module.databricks_workspace_management.databricks_permissions_policy
}

output "databricks_permissions_pool" {
  description = "databricks instance pool permissions"
  value       = module.databricks_workspace_management.databricks_permissions_pool
}
