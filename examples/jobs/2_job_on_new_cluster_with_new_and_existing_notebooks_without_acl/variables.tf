variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "workspace_url" {
  description = "databricks workspace url"
  type        = string
}

variable "dapi_token" {
  description = "databricks dapi token"
  type        = string
}
