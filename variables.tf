variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "workspace_url" {}
# ------------------------------------------------
# Token
# ------------------------------------------------
variable "dapi_token" {}

variable "dapi_token_duration" {
  default = 3600
}

variable "databricks_secret_key" {
  default = "token"
}
# ------------------------------------------------
# Instance Pool
# ------------------------------------------------
variable "min_idle_instances" {
  default = 0
}

variable "max_capacity" {
  default = 30
}

variable "idle_instance_autotermination_minutes" {
  default = 20
}
# ------------------------------------------------
# Cluster
# ------------------------------------------------
variable "cluster_autotermination_minutes" {
  default = 20
}

variable "cluster_min_workers" {
  default = 1
}

variable "cluster_max_workers" {
  default = 10
}

variable "cluster_policy_max_dbus_per_hour" {
  default = 10
}

variable "cluster_policy_autotermination_minutes" {
  default = 20
}
# ------------------------------------------------
# Job
# ------------------------------------------------
variable "num_workers" {
  default = 1
}
# ------------------------------------------------
# Notebook
# ------------------------------------------------
variable "language" {
  default = "PYTHON"
}

variable "notebook_name" {
  default = null
}

variable "notebook_path" {
  description = "notebook location on user machine"
}