#TODO: where to integrate?
data "databricks_node_type" "cluster_node_type" {
  count = var.deploy_cluster ? 1 : 0

  local_disk    = var.local_disk
  min_cores     = var.min_cores
  gb_per_core   = var.gb_per_core
  min_gpus      = var.min_gpus
  min_memory_gb = var.min_memory_gb
  category      = var.category
}
