variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
  type        = string
}

variable "aws_region" {
  description = "aws region to deploy resources"
  default     = "us-west-2"
  type        = string
}

variable "workspace_url" {
  description = "databricks workspace url"
  type        = string
}
# ------------------------------------------------
# Token
# ------------------------------------------------
variable "dapi_token" {
  description = "databricks dapi token"
  type        = string
}

variable "dapi_token_duration" {
  description = "databricks dapi token duration"
  type        = number
  default     = 3600
}

variable "databricks_secret_key" {
  description = "databricks token type"
  type        = string
  default     = "token"
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


variable "cluster_autotermination_minutes" {
  description = "cluster auto termination duration"
  type        = number
  default     = 20
}

variable "cluster_policy_max_dbus_per_hour" {
  description = "cluster maximum dbus per hour"
  type        = number
  default     = 10
}

variable "cluster_policy_autotermination_minutes" {
  description = "cluster policy auto termination minutes."
  type        = number
  default     = 20
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
  description = "Optional configuration block contains attributes related to clusters running on AWS"
  type        = any
  default     = null
}
# ------------------------------------------------
# Job
# ------------------------------------------------
variable "deploy_job" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "num_workers" {
  description = "number of workers for job"
  type        = number
  default     = 1
}

variable "email_notifications" {
  description = "Email notification block."
  type        = any
  default     = null
}
# ------------------------------------------------
# Notebook
# ------------------------------------------------
variable "language" {
  description = "notebook language"
  type        = string
  default     = "PYTHON"
}

variable "notebook_name" {
  description = "notebook name"
  type        = string
  default     = null
}

variable "local_path" {
  description = "notebook location on user machine"
  type        = string
  default     = null
}

variable "deploy_notebook" {
  description = "feature flag, true or false"
  default     = false
  type        = bool
}

variable "notebook_info" {
  description = "Notebook information"
  type = map(object({
    language   = string
    local_path = string
  }))
  default = {
  }
  /*
      default = {
        language   = "PYTHON"
        local_path = "notebooks/sample.py"
      }
    }
  */
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

variable "note_type_id" {
  description = "Type of node"
  type        = string
  default     = null
}

variable "deploy_instance_pool" {
  description = "Deploy instance pool"
  type        = bool
  default     = false
}
# ------------------------------------------------
# Spark version
# ------------------------------------------------
variable "gpu" {
  description = "GPU required or not"
  type        = bool
  default     = false
}

variable "ml" {
  description = "ML required or not"
  type        = bool
  default     = false
}
# ------------------------------------------------
# Databricks admin console
# ------------------------------------------------
variable "databricks_username" {
  description = "List of user allowed to access the platform"
  type        = string
  default     = null
}

variable "databricks_groupname" {
  description = "Group allowed to access the platform"
  type        = string
  default     = null
}

variable "driver_node_type_id" {
  description = "The node type of the Spark driver. This field is optional; if unset, API will set the driver node type to the same value as node_type_id"
  type        = string
  default     = null
}
