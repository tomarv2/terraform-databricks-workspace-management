output "cluster_id" {
  description = "databricks cluster id"
  value       = module.databricks_workspace_management.cluster_id
}

output "standalone_cluster_id" {
  description = "databricks standalone cluster id"
  value       = module.databricks_workspace_management.single_node_cluster_id
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

output "cluster_policy_id" {
  description = "databricks cluster policy permissions"
  value       = module.databricks_workspace_management.cluster_policy_id
}
