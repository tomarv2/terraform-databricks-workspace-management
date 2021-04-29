output "databricks_host" {
  value = module.databricks_workspace_management.databricks_host
}

// export token for integration tests to run on
output "databricks_token" {
  value     = module.databricks_workspace_management.databricks_token
  //sensitive = true
}

output "databricks_job_url" {
  value = module.databricks_workspace_management.job_url
}

output "databricks_job_notebook_url" {
  value = module.databricks_workspace_management.notebook_url
}

//// workspace security
//output "databricks_secret_acl" {
//  value = module.databricks_workspace_management.databricks_secret_acl
//}
//
//output "databricks_group" {
//  value = module.databricks_workspace_management.databricks_group
//}
//
//output "databricks_user" {
//  value = module.databricks_workspace_management.databricks_user
//}
//
//output "databricks_group_member" {
//  value = module.databricks_workspace_management.databricks_group_member
//}
//
//output "databricks_permissions_notebook" {
//  value = module.databricks_workspace_management.databricks_permissions_notebook
//}
//
//output "databricks_permissions_job" {
//  value = module.databricks_workspace_management.databricks_permissions_job
//}
//
//output "databricks_permissions_cluster" {
//  value = module.databricks_workspace_management.databricks_permissions_cluster
//}
//
//output "databricks_permissions_policy" {
//  value = module.databricks_workspace_management.databricks_permissions_policy
//}
//
//output "databricks_permissions_pool" {
//  value = module.databricks_workspace_management.databricks_permissions_pool
//}