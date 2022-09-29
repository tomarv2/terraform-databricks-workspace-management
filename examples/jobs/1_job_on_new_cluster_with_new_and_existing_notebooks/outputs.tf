output "cluster_id" {
  description = "databricks cluster id"
  value       = module.job.cluster_id
}

output "notebook_url" {
  description = "databricks notebook url"
  value       = module.job.notebook_url
}
output "job_url" {
  description = "databricks job url"
  value       = module.job.new_cluster_new_job_new_notebooks_job
}

output "job_id" {
  description = "databricks job id"
  value       = module.job.new_cluster_new_job_new_notebooks_id
}

output "notebooks_id" {
  description = "databricks notebook id"
  value       = module.job.new_cluster_new_job_existing_notebooks_id
}
