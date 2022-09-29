output "notebook_url" {
  description = "databricks notebook url"
  value       = module.job.notebook_url
}

output "job_url" {
  description = "databricks job url"
  value       = module.job.existing_cluster_new_job_new_notebooks_job
}

output "job_id" {
  description = "databricks job id"
  value       = module.job.existing_cluster_new_job_new_notebooks_id
}

output "cluster_id" {
  description = "databricks cluster id"
  value = module.cluster.cluster_id
}