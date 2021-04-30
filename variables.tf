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
# Instance Pool
# ------------------------------------------------
variable "min_idle_instances" {
  description = "instance pool minimum idle instances"
  type        = number
  default     = 0
}

variable "max_capacity" {
  description = "instance pool maximum capacity"
  type        = number
  default     = 30
}

variable "idle_instance_autotermination_minutes" {
  description = "idle instance auto termination duration"
  type        = number
  default     = 20
}
# ------------------------------------------------
# Cluster
# ------------------------------------------------
variable "cluster_autotermination_minutes" {
  description = "cluster auto termination duration"
  type        = number
  default     = 20
}

variable "cluster_min_workers" {
  description = "cluster minimum workers"
  type        = number
  default     = 1
}

variable "cluster_max_workers" {
  description = "cluster maximum workers"
  type        = number
  default     = 10
}

variable "cluster_policy_max_dbus_per_hour" {
  description = "cluster maximum dbus per hour"
  type        = number
  default     = 10
}

variable "cluster_policy_autotermination_minutes" {
  description = "cluster policy auto termination minutes"
  type        = number
  default     = 20
}
# ------------------------------------------------
# Job
# ------------------------------------------------
variable "num_workers" {
  description = "number of workers for job"
  type        = number
  default     = 1
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

variable "notebook_path" {
  description = "notebook location on user machine"
  type        = string
}
