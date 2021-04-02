locals {
  shared_tags = map(
    "Name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )

  notebook_name = var.notebook_name != null ? var.notebook_name : "${var.teamid}-${var.prjid}"
}
