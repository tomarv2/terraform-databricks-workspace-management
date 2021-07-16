<p align="center">
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-databricks-workspace-management/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-databricks-workspace-management" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [Databricks Workspace Management (Part 2)](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management)

> ❗️ **Important**
>
> :point_right: This Terraform module assumes you have [Databricks Workspace](https://github.com/tomarv2/terraform-databricks-workspace) already deployed.
>
> :point_right: Workspace URL
>
> :point_right: DAPI Token

## Versions

- Module tested for Terraform 1.0.1.
- `databrickslabs/databricks` provider version [0.3.5](https://registry.terraform.io/providers/databrickslabs/databricks/latest)
- AWS provider version [3.47.0](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>).

---
![Databricks deployment](https://github.com/tomarv2/terraform-databricks-workspace-management/raw/main/docs/images/databricks-workspace-management.png)
---

## What this module does?

##### [Create Cluster:](examples/cluster)

- This is where you would normally start with if you have just deployed your databricks workspace.

Two cluster modes are supported by this module:

- `Single Node` mode: To deploy cluster in Single Node mode, update `fixed_value` to `0`:
```
fixed_value         = 0
```

- `Standard` mode: To deploy in Standard mode, two options are available:

```
fixed_value         = 1 or more
```
OR
```
auto_scaling         = [1,3]
```

**Note:** To configure `Instance Pool`, add below configuration:

```
deploy_instance_pool                  = true
min_idle_instances                    = 1
max_capacity                          = 5
idle_instance_autotermination_minutes = 30
```

> ❗️ **Important**
>
> If `deploy_instance_pool` is set to `true` and `auto_scaling` is enabled.
> Ensure `max_capacity` of Cluster Instance Pool is more than `auto_scaling` max value for Cluster.

##### [Deploy Job on a new or existing cluster:](examples/job)

Two options are available:

- Deploy Job to an existing cluster.
- Deploy new cluster and deploy Job.

Note: `Job name` and `Notebook name` is same.

##### [Deploy Notebook:](examples/notebook)

Put notebooks in notebooks folder and provide below information:

```
notebook_info = {
  demo1 = {
    custom_path     = "<to overwrite default path on remote location>"
    language        = "PYTHON"
    local_path      = "notebooks/demo_notebook_1.py"
  }
  demo2 = {
    custom_path     = "<to overwrite default path on remote location>"
    language        = "PYTHON"
    local_path      = "notebooks/demo_notebook_2.py"
  }
}
```

##### [Deploy everything(cluster,job, and notebook):](examples/all)

- Try this: If you want to test what resources are getting deployed.

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (store remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.6+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_PROFILE=default
export TF_AWS_BUCKET_REGION=us-west-2
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -c=aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=aws destroy -var='teamid=foo' -var='prjid=bar'
```
**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)
---

#### Databricks workspace management with default config
```
module "databricks_workspace_management" {
  source = "git::git@github.com:tomarv2/terraform-databricks-workspace-management.git"

  workspace_url = "https://<workspace-url>.cloud.sample.com"
  dapi_token    = "dapi123456789012"

  deploy_cluster  = true
  deploy_job      = true
  deploy_notebook = true
  notebook_path   = "notebooks/sample.py"
  notebook_name   = "sec-test"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Coming up

- [**Storage**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management#part-3-storage)
- [**Advanced configuration**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management#part-4-advanced-configuration)
- [**Init Script**](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/global_init_script)

## Helpful links

- [Databricks Sync](https://github.com/databrickslabs/databricks-sync) - Tool for multi cloud migrations, DR sync of workspaces. It uses TF in the backend. Run it from command line or from a notebook.
- [Databricks Migrate](https://github.com/databrickslabs/migrate) - Tool to migrate a workspace(One time tool).
- [Databricks CICD Templates](https://github.com/databrickslabs/cicd-templates)

#### Troubleshooting

Common error messages. Try the step one again if you below error.

```
Error: Failed to delete token in Scope <scope name>
```

```
Error: Scope <scope name> does not exist!
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.47 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | ~> 0.3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 0.3.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_cluster.cluster](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/cluster) | resource |
| [databricks_cluster.single_node_cluster](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/cluster) | resource |
| [databricks_cluster_policy.this](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/cluster_policy) | resource |
| [databricks_group.this](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.group_members](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/group_member) | resource |
| [databricks_instance_pool.instance_nodes](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/instance_pool) | resource |
| [databricks_job.databricks_job](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/job) | resource |
| [databricks_job.databricks_new_cluster_job](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/job) | resource |
| [databricks_notebook.notebook_file](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/notebook) | resource |
| [databricks_permissions.cluster](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.job](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.notebook](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.policy](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.pool](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_secret_acl.spectators](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/secret_acl) | resource |
| [databricks_secret_scope.this](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/secret_scope) | resource |
| [databricks_user.users](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/user) | resource |
| [databricks_current_user.me](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/data-sources/current_user) | data source |
| [databricks_node_type.cluster_node_type](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/data-sources/node_type) | data source |
| [databricks_spark_version.latest](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/data-sources/spark_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_cluster_create"></a> [allow\_cluster\_create](#input\_allow\_cluster\_create) | This is a field to allow the group to have cluster create privileges. More fine grained permissions could be assigned with databricks\_permissions and cluster\_id argument. Everyone without allow\_cluster\_create argument set, but with permission to use Cluster Policy would be able to create clusters, but within boundaries of that specific policy. | `bool` | `true` | no |
| <a name="input_allow_instance_pool_create"></a> [allow\_instance\_pool\_create](#input\_allow\_instance\_pool\_create) | This is a field to allow the group to have instance pool create privileges. More fine grained permissions could be assigned with databricks\_permissions and instance\_pool\_id argument. | `bool` | `true` | no |
| <a name="input_allow_sql_analytics_access"></a> [allow\_sql\_analytics\_access](#input\_allow\_sql\_analytics\_access) | This is a field to allow the group to have access to SQL Analytics feature through databricks\_sql\_endpoint. | `bool` | `true` | no |
| <a name="input_auto_scaling"></a> [auto\_scaling](#input\_auto\_scaling) | Number of min and max workers in auto scale. | `list(any)` | `null` | no |
| <a name="input_aws_attributes"></a> [aws\_attributes](#input\_aws\_attributes) | Optional configuration block contains attributes related to clusters running on AWS | `any` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | aws region to deploy resources | `string` | `"us-west-2"` | no |
| <a name="input_category"></a> [category](#input\_category) | Node category, which can be one of: General purpose, Memory optimized, Storage optimized, Compute optimized, GPU | `string` | `"General purpose"` | no |
| <a name="input_cluster_autotermination_minutes"></a> [cluster\_autotermination\_minutes](#input\_cluster\_autotermination\_minutes) | cluster auto termination duration | `number` | `20` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Existing cluster id | `string` | `null` | no |
| <a name="input_cluster_policy_autotermination_minutes"></a> [cluster\_policy\_autotermination\_minutes](#input\_cluster\_policy\_autotermination\_minutes) | cluster policy auto termination minutes. | `number` | `20` | no |
| <a name="input_cluster_policy_max_dbus_per_hour"></a> [cluster\_policy\_max\_dbus\_per\_hour](#input\_cluster\_policy\_max\_dbus\_per\_hour) | cluster maximum dbus per hour | `number` | `10` | no |
| <a name="input_create_group"></a> [create\_group](#input\_create\_group) | Create a new group, if group already exists the deployment will fail. | `bool` | `false` | no |
| <a name="input_create_user"></a> [create\_user](#input\_create\_user) | Create a new user, if user already exists the deployment will fail. | `bool` | `false` | no |
| <a name="input_custom_path"></a> [custom\_path](#input\_custom\_path) | Custom path to the notebook | `string` | `""` | no |
| <a name="input_dapi_token"></a> [dapi\_token](#input\_dapi\_token) | databricks dapi token | `string` | n/a | yes |
| <a name="input_dapi_token_duration"></a> [dapi\_token\_duration](#input\_dapi\_token\_duration) | databricks dapi token duration | `number` | `3600` | no |
| <a name="input_databricks_groupname"></a> [databricks\_groupname](#input\_databricks\_groupname) | Group allowed to access the platform. | `string` | `""` | no |
| <a name="input_databricks_secret_key"></a> [databricks\_secret\_key](#input\_databricks\_secret\_key) | databricks token type | `string` | `"token"` | no |
| <a name="input_databricks_username"></a> [databricks\_username](#input\_databricks\_username) | User allowed to access the platform. | `string` | `""` | no |
| <a name="input_deploy_cluster"></a> [deploy\_cluster](#input\_deploy\_cluster) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_deploy_instance_pool"></a> [deploy\_instance\_pool](#input\_deploy\_instance\_pool) | Deploy instance pool | `bool` | `false` | no |
| <a name="input_deploy_job"></a> [deploy\_job](#input\_deploy\_job) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_deploy_notebook"></a> [deploy\_notebook](#input\_deploy\_notebook) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_driver_node_type_id"></a> [driver\_node\_type\_id](#input\_driver\_node\_type\_id) | The node type of the Spark driver. This field is optional; if unset, API will set the driver node type to the same value as node\_type\_id. | `string` | `null` | no |
| <a name="input_email_notifications"></a> [email\_notifications](#input\_email\_notifications) | Email notification block. | `any` | `null` | no |
| <a name="input_fixed_value"></a> [fixed\_value](#input\_fixed\_value) | Number of nodes in the cluster. | `number` | `0` | no |
| <a name="input_gb_per_core"></a> [gb\_per\_core](#input\_gb\_per\_core) | Number of gigabytes per core available on instance. Conflicts with min\_memory\_gb. Defaults to 0. | `string` | `0` | no |
| <a name="input_gpu"></a> [gpu](#input\_gpu) | GPU required or not. | `bool` | `false` | no |
| <a name="input_idle_instance_autotermination_minutes"></a> [idle\_instance\_autotermination\_minutes](#input\_idle\_instance\_autotermination\_minutes) | idle instance auto termination duration | `number` | `20` | no |
| <a name="input_language"></a> [language](#input\_language) | notebook language | `string` | `"PYTHON"` | no |
| <a name="input_local_disk"></a> [local\_disk](#input\_local\_disk) | Pick only nodes with local storage. Defaults to false. | `string` | `true` | no |
| <a name="input_local_path"></a> [local\_path](#input\_local\_path) | notebook location on user machine | `string` | `null` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | instance pool maximum capacity | `number` | `3` | no |
| <a name="input_max_concurrent_runs"></a> [max\_concurrent\_runs](#input\_max\_concurrent\_runs) | An optional maximum allowed number of concurrent runs of the job. | `number` | `null` | no |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | An optional maximum number of times to retry an unsuccessful run. A run is considered to be unsuccessful if it completes with a FAILED result\_state or INTERNAL\_ERROR life\_cycle\_state. The value -1 means to retry indefinitely and the value 0 means to never retry. The default behavior is to never retry. | `number` | `0` | no |
| <a name="input_min_cores"></a> [min\_cores](#input\_min\_cores) | Minimum number of CPU cores available on instance. Defaults to 0. | `string` | `0` | no |
| <a name="input_min_gpus"></a> [min\_gpus](#input\_min\_gpus) | Minimum number of GPU's attached to instance. Defaults to 0. | `string` | `0` | no |
| <a name="input_min_idle_instances"></a> [min\_idle\_instances](#input\_min\_idle\_instances) | instance pool minimum idle instances | `number` | `1` | no |
| <a name="input_min_memory_gb"></a> [min\_memory\_gb](#input\_min\_memory\_gb) | Minimum amount of memory per node in gigabytes. Defaults to 0. | `string` | `0` | no |
| <a name="input_min_retry_interval_millis"></a> [min\_retry\_interval\_millis](#input\_min\_retry\_interval\_millis) | An optional minimal interval in milliseconds between the start of the failed run and the subsequent retry run. The default behavior is that unsuccessful runs are immediately retried. | `number` | `null` | no |
| <a name="input_ml"></a> [ml](#input\_ml) | ML required or not. | `bool` | `false` | no |
| <a name="input_note_type_id"></a> [note\_type\_id](#input\_note\_type\_id) | Type of node | `string` | `null` | no |
| <a name="input_notebook_info"></a> [notebook\_info](#input\_notebook\_info) | Notebook information | <pre>map(object({<br>    language   = string<br>    local_path = string<br>  }))</pre> | `{}` | no |
| <a name="input_notebook_name"></a> [notebook\_name](#input\_notebook\_name) | notebook name | `string` | `null` | no |
| <a name="input_num_workers"></a> [num\_workers](#input\_num\_workers) | number of workers for job | `number` | `1` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_profile_to_use"></a> [profile\_to\_use](#input\_profile\_to\_use) | Getting values from ~/.aws/credentials | `string` | `"default"` | no |
| <a name="input_retry_on_timeout"></a> [retry\_on\_timeout](#input\_retry\_on\_timeout) | An optional policy to specify whether to retry a job when it times out. The default behavior is to not retry on timeout. | `bool` | `false` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Job schedule configuration. | `map(any)` | `null` | no |
| <a name="input_task_parameters"></a> [task\_parameters](#input\_task\_parameters) | Base parameters to be used for each run of this job. | `map(any)` | `{}` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | An optional timeout applied to each run of this job. The default behavior is to have no timeout. | `number` | `null` | no |
| <a name="input_workspace_url"></a> [workspace\_url](#input\_workspace\_url) | databricks workspace url | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | databricks cluster id |
| <a name="output_databricks_group"></a> [databricks\_group](#output\_databricks\_group) | databricks group name |
| <a name="output_databricks_group_member"></a> [databricks\_group\_member](#output\_databricks\_group\_member) | databricks group members |
| <a name="output_databricks_permissions_cluster"></a> [databricks\_permissions\_cluster](#output\_databricks\_permissions\_cluster) | databricks cluster permissions |
| <a name="output_databricks_permissions_policy"></a> [databricks\_permissions\_policy](#output\_databricks\_permissions\_policy) | databricks cluster policy |
| <a name="output_databricks_permissions_pool"></a> [databricks\_permissions\_pool](#output\_databricks\_permissions\_pool) | databricks instance pool permissions |
| <a name="output_databricks_secret_acl"></a> [databricks\_secret\_acl](#output\_databricks\_secret\_acl) | databricks secret acl |
| <a name="output_databricks_user"></a> [databricks\_user](#output\_databricks\_user) | databricks user name |
| <a name="output_databricks_user_id"></a> [databricks\_user\_id](#output\_databricks\_user\_id) | databricks user id |
| <a name="output_job_id"></a> [job\_id](#output\_job\_id) | databricks job id |
| <a name="output_job_new_cluster_id"></a> [job\_new\_cluster\_id](#output\_job\_new\_cluster\_id) | databricks new cluster job id |
| <a name="output_job_new_cluster_url"></a> [job\_new\_cluster\_url](#output\_job\_new\_cluster\_url) | databricks new cluster job url |
| <a name="output_job_url"></a> [job\_url](#output\_job\_url) | databricks job url |
| <a name="output_notebook_url"></a> [notebook\_url](#output\_notebook\_url) | databricks notebook url |
