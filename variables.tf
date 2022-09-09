variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}
# ------------------------------------------------
# Cluster Instance Pool
# ------------------------------------------------
variable "min_idle_instances" {
  description = "instance pool minimum idle instances"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "instance pool maximum capacity"
  type        = number
  default     = 3
}

variable "idle_instance_autotermination_minutes" {
  description = "idle instance auto termination duration"
  type        = number
  default     = 20
}
# ------------------------------------------------
# Cluster
# ------------------------------------------------
variable "deploy_cluster" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "deploy_job_cluster" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "cluster_autotermination_minutes" {
  description = "cluster auto termination duration"
  type        = number
  default     = 30
}

variable "deploy_cluster_policy" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "cluster_policy_id" {
  description = "Exiting cluster policy id"
  type        = string
  default     = null
}

variable "policy_overrides" {
  description = "Cluster policy overrides"
  type        = any
  default     = null
}

variable "auto_scaling" {
  description = "Number of min and max workers in auto scale."
  type        = list(any)
  default     = null
}

variable "fixed_value" {
  description = "Number of nodes in the cluster."
  type        = number
  default     = 0
}

variable "aws_attributes" {
  description = "Optional configuration block contains attributes related to clusters running on AWS."
  type        = any
  default     = null
}

variable "azure_attributes" {
  description = "Optional configuration block contains attributes related to clusters running on Azure."
  type        = any
  default     = null
}

variable "gcp_attributes" {
  description = "Optional configuration block contains attributes related to clusters running on GCP."
  type        = any
  default     = null
}

variable "spark_env_vars" {
  description = "Map with environment variable key-value pairs to fine-tune Spark clusters. Key-value pairs of the form (X,Y) are exported (i.e., X='Y') while launching the driver and workers."
  type        = any
  default     = null
}

variable "spark_conf" {
  description = "Map with key-value pairs to fine-tune Spark clusters, where you can provide custom Spark configuration properties in a cluster configuration."
  type        = any
  default     = null
}

variable "add_instance_profile_to_workspace" {
  description = "Existing AWS instance profile ARN"
  type        = bool
  default     = false
}
# ------------------------------------------------
# Job
# ------------------------------------------------
variable "deploy_jobs" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "email_notifications" {
  description = "Email notification block."
  type        = any
  default     = null
}

variable "schedule" {
  description = "Job schedule configuration."
  type        = map(any)
  default     = null
}

variable "task_parameters" {
  description = "Base parameters to be used for each run of this job."
  type        = map(any)
  default     = {}
}

variable "retry_on_timeout" {
  description = "An optional policy to specify whether to retry a job when it times out. The default behavior is to not retry on timeout."
  type        = bool
  default     = false
}

variable "max_retries" {
  description = " An optional maximum number of times to retry an unsuccessful run. A run is considered to be unsuccessful if it completes with a FAILED result_state or INTERNAL_ERROR life_cycle_state. The value -1 means to retry indefinitely and the value 0 means to never retry. The default behavior is to never retry."
  type        = number
  default     = 0
}

variable "timeout" {
  description = "An optional timeout applied to each run of this job. The default behavior is to have no timeout."
  default     = null
  type        = number
}

variable "min_retry_interval_millis" {
  description = "An optional minimal interval in milliseconds between the start of the failed run and the subsequent retry run. The default behavior is that unsuccessful runs are immediately retried."
  default     = null
  type        = number
}

variable "max_concurrent_runs" {
  description = "An optional maximum allowed number of concurrent runs of the job."
  default     = null
  type        = number
}

variable "always_running" {
  description = "Whenever the job is always running, like a Spark Streaming application, on every update restart the current active run or start it again, if nothing it is not running. False by default."
  default     = false
  type        = bool
}
# ------------------------------------------------
# Notebook
# ------------------------------------------------
variable "local_notebooks" {
  description = "Local path to the notebook(s) that will be used by the job"
  type        = any
  default     = []
}

variable "remote_notebooks" {
  description = "Path to notebook(s) in the databricks workspace that will be used by the job"
  type        = any
  default     = []
}

variable "notebooks" {
  description = "Local path to the notebook(s) that will be deployed"
  type        = any
  default     = []
}

# ------------------------------------------------
# Cluster Node type
# ------------------------------------------------
variable "local_disk" {
  description = "Pick only nodes with local storage. Defaults to false."
  type        = string
  default     = true
}

variable "min_cores" {
  description = "Minimum number of CPU cores available on instance. Defaults to 0."
  type        = string
  default     = 0
}

variable "gb_per_core" {
  description = "Number of gigabytes per core available on instance. Conflicts with min_memory_gb. Defaults to 0."
  type        = string
  default     = 0
}

variable "min_gpus" {
  description = "Minimum number of GPU's attached to instance. Defaults to 0."
  type        = string
  default     = 0
}

variable "min_memory_gb" {
  description = "Minimum amount of memory per node in gigabytes. Defaults to 0."
  type        = string
  default     = 0
}

variable "category" {
  description = "Node category, which can be one of: General purpose, Memory optimized, Storage optimized, Compute optimized, GPU"
  type        = string
  default     = "General purpose"
}

variable "cluster_id" {
  description = "Existing cluster id"
  type        = string
  default     = null
}

variable "worker_node_type_id" {
  description = "The node type of the Spark worker."
  type        = string
  default     = null
}

variable "deploy_worker_instance_pool" {
  description = "Worker instance pool"
  type        = bool
  default     = false
}

variable "deploy_driver_instance_pool" {
  description = "Driver instance pool"
  type        = bool
  default     = false
}
# ------------------------------------------------
# Spark version
# ------------------------------------------------
variable "gpu" {
  description = "GPU required or not."
  type        = bool
  default     = false
}

variable "ml" {
  description = "ML required or not."
  type        = bool
  default     = false
}

variable "spark_version" {
  description = "Runtime version of the cluster. Any supported databricks_spark_version id. We advise using Cluster Policies to restrict the list of versions for simplicity while maintaining enough control."
  type        = string
  default     = null
}
# ------------------------------------------------
# Databricks admin console
# ------------------------------------------------
variable "create_user" {
  description = "Create a new user, if user already exists the deployment will fail."
  type        = bool
  default     = false
}

variable "create_group" {
  description = "Create a new group, if group already exists the deployment will fail."
  type        = bool
  default     = false
}

variable "databricks_username" {
  description = "User allowed to access the platform."
  type        = string
  default     = ""
}

variable "driver_node_type_id" {
  description = "The node type of the Spark driver. This field is optional; if unset, API will set the driver node type to the same value as node_type_id."
  type        = string
  default     = null
}

variable "allow_cluster_create" {
  description = " This is a field to allow the group to have cluster create privileges. More fine grained permissions could be assigned with databricks_permissions and cluster_id argument. Everyone without allow_cluster_create argument set, but with permission to use Cluster Policy would be able to create clusters, but within boundaries of that specific policy."
  type        = bool
  default     = true
}

variable "allow_instance_pool_create" {
  description = "This is a field to allow the group to have instance pool create privileges. More fine grained permissions could be assigned with databricks_permissions and instance_pool_id argument."
  type        = bool
  default     = true
}

variable "cluster_access_control" {
  type        = any
  description = "Cluster access control"
  default     = null
}

variable "instance_pool_access_control" {
  type        = any
  description = "Instance pool access control"
  default     = null
}

variable "policy_access_control" {
  type        = any
  description = "Policy access control"
  default     = null
}

variable "jobs_access_control" {
  type        = any
  description = "Jobs access control"
  default     = null
}

variable "notebooks_access_control" {
  type        = any
  description = "Notebook access control"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
  default     = null
}

variable "custom_tags" {
  type        = any
  description = "Extra custom tags"
  default     = null
}

variable "libraries" {
  type = map(any)
  description = "Installs a library on databricks_cluster"
  default = {}
}
