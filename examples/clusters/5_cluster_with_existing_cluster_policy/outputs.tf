output "cluster_id" {
  description = "databricks cluster id"
  value       = module.cluster.cluster_id
}

output "databricks_secret_acl" {
  description = "databricks secret acl"
  value       = module.cluster.databricks_secret_acl
}

output "databricks_group" {
  description = "databricks group name"
  value       = module.cluster.databricks_group
}

output "databricks_user" {
  description = "databricks user name"
  value       = module.cluster.databricks_user
}

output "databricks_user_id" {
  description = "databricks user id"
  value       = module.cluster.databricks_user_id
}

output "databricks_group_member" {
  description = "databricks group members"
  value       = module.cluster.databricks_group_member
}

output "cluster_policy_id" {
  description = "databricks cluster policy permissions"
  value       = module.cluster.cluster_policy_id
}
