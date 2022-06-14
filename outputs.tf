output "cluster_id" {
  description = "databricks cluster id"
  value       = var.deploy_cluster == true ? databricks_cluster.cluster[local.cluster_name].id : null
}

output "cluster_name" {
  description = "databricks cluster name"
  value       = var.deploy_cluster == true ? databricks_cluster.cluster[local.cluster_name].cluster_name : null
}

output "notebook_url" {
  description = "databricks notebook url"
  value       = { for k, v in databricks_notebook.notebook_file : k => v.url }
}

output "notebook_url_standalone" {
  description = "databricks notebook url standalone"
  value       = { for k, v in databricks_notebook.notebook_file_deployment : k => v.url }
}

output "new_cluster_new_job_new_notebooks_job" {
  description = "databricks job url"
  value       = { for k, v in databricks_job.new_cluster_new_job_new_notebooks : k => v.url }
}

output "new_cluster_new_job_new_notebooks_id" {
  description = "databricks job id"
  value       = { for k, v in databricks_job.new_cluster_new_job_new_notebooks : k => v.id }
}

output "existing_cluster_new_job_new_notebooks_job" {
  description = "databricks new cluster job url"
  value       = { for k, v in databricks_job.existing_cluster_new_job_new_notebooks : k => v.url }
}

output "existing_cluster_new_job_new_notebooks_id" {
  description = "databricks new cluster job id"
  value       = { for k, v in databricks_job.existing_cluster_new_job_new_notebooks : k => v.id }
}

output "new_cluster_new_job_existing_notebooks_job" {
  description = "databricks job url"
  value       = { for k, v in databricks_job.new_cluster_new_job_existing_notebooks : k => v.url }
}

output "new_cluster_new_job_existing_notebooks_id" {
  description = "databricks job id"
  value       = { for k, v in databricks_job.new_cluster_new_job_existing_notebooks : k => v.id }
}

output "existing_cluster_new_job_existing_notebooks_job" {
  description = "databricks new cluster job url"
  value       = { for k, v in databricks_job.existing_cluster_new_job_existing_notebooks : k => v.url }
}

output "existing_cluster_new_job_existing_notebooks_id" {
  description = "databricks new cluster job id"
  value       = { for k, v in databricks_job.existing_cluster_new_job_existing_notebooks : k => v.id }
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

output "cluster_policy_id" {
  description = "databricks cluster policy permissions"
  value       = join("", databricks_permissions.policy.*.id)
}

output "instance_profile" {
  description = "databricks instance profile ARN"
  value       = join("", databricks_instance_profile.shared.*.instance_profile_arn)
}
