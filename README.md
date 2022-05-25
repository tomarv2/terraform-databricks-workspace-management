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
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [Databricks Workspace Management (Part 2)](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/guides/workspace-management)

> ❗️ **Important**
>
> :point_right: This module assumes you have Databricks Workspace [AWS](https://github.com/tomarv2/terraform-databricks-workspace) or Azure already deployed.
>
> :point_right: Workspace URL
>
> :point_right: DAPI Token

## Versions

- Module tested for Terraform 1.0.1.
- `databrickslabs/databricks` provider version [0.5.7](https://registry.terraform.io/providers/databrickslabs/databricks/latest)
- AWS provider version [4.14](https://registry.terraform.io/providers/hashicorp/aws/latest).
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-databricks-workspace-management/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-databricks-workspace-management" /></a>).

<p align="center">
    <img width="700" height="350"  src="https://github.com/tomarv2/terraform-databricks-workspace-management/raw/main/docs/images/databricks-workspace-management.png">
</p>

## What this module does?

### [Deploy Cluster](examples/clusters)

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

### [Cluster ACL](https://docs.databricks.com/security/access-control/cluster-acl.html)

Cluster can have one of these permissions:  `CAN_ATTACH_TO` , `CAN_RESTART` and `CAN_MANAGE`.

```
cluster_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_RESTART"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_RESTART"
  }
]
```

### [Cluster Policy](https://docs.databricks.com/administration-guide/clusters/policies.html)

- To build cluster with new cluster policy, use:
```
deploy_cluster_policy = true
policy_overrides = {
  "dbus_per_hour" : {
    "type" : "range",
    "maxValue" : 10
  },
  "autotermination_minutes" : {
    "type" : "fixed",
    "value" : 30,
    "hidden" : true
  }
}
```

- To use existing Cluster policy, specify the existing policy id:
```
cluster_policy_id = "E0123456789"
```

To get existing policy id use:
```
curl -X GET --header "Authorization: Bearer $DAPI_TOKEN"  https://<workspace_name>/api/2.0/policies/clusters/list \
--data '{ "sort_order": "DESC", "sort_column": "POLICY_CREATION_TIME" }'
```

### Cluster Policy ACL

```
policy_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_USE"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_USE"
  }
]
```

### [Instance Pool](https://docs.databricks.com/clusters/instance-pools/index.html)
**Note:** To configure `Instance Pool`, add below configuration:

```
deploy_worker_instance_pool           = true
min_idle_instances                    = 1
max_capacity                          = 5
idle_instance_autotermination_minutes = 30
```

### [Instance Pool ACL](https://docs.databricks.com/security/access-control/pool-acl.html)

Instance pool can have one of these permissions:  `CAN_ATTACH_TO` and `CAN_MANAGE`.

```
instance_pool_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_ATTACH_TO"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_ATTACH_TO"
  },
]
```

> ❗️ **Important**
>
> If `deploy_worker_instance_pool` is set to `true` and `auto_scaling` is enabled.
> Ensure `max_capacity` of Cluster Instance Pool is more than `auto_scaling` max value for Cluster.

### [Deploy Job](examples/jobs)

Two options are available:

- Deploy Job to an existing cluster.
- Deploy new Cluster and then deploy Job.

Two options are available to attach notebooks to a job:

- Attach existing notebook to a job.
- Create new notebook and attach it to a job.

### [Jobs ACL](https://docs.databricks.com/security/access-control/jobs-acl.html)

Job can have one of these permissions:  `CAN_VIEW`, `CAN_MANAGE_RUN`, `IS_OWNER`, and `CAN_MANAGE`.

Admins have `CAN_MANAGE` permission by default, and they can assign that permission to non-admin users, and service principals.

Job creator has `IS_OWNER` permission. Destroying databricks_permissions resource for a job would revert ownership to the creator.

**Note:**
- A job must have exactly one owner. If resource is changed and no owner is specified, currently authenticated principal would become new owner of the job.
- A job cannot have a **group** as an owner.
- Jobs triggered through Run Now assume the permissions of the job owner and not the user, and service principal who issued Run Now.

```
jobs_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_MANAGE_RUN"
  },
   {
    user_name       = "<user_name>"
    permission_level = "CAN_MANAGE_RUN"
  }
]
```

### AWS only
### [Instance Profile](https://docs.databricks.com/administration-guide/cloud-configurations/aws/instance-profiles.html)

Add instance profile at cluster creation time. It can control which data a given cluster can access through cloud-native controls.
```
add_instance_profile_to_workspace = true (default false)
aws_attributes = {
    instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/aws-instance-role"
}
```

Note: `add_instance_profile_to_workspace` to add Instance profile to Databricks workspace. To use existing set it to `false`.

### [Deploy Notebook](examples/notebooks)

Put notebooks in notebooks folder and provide below information:

```
  notebooks = [
    {
      name       = "demo_notebook1"
      language   = "PYTHON"
      local_path = "notebooks/sample1.py"
      path       = "/Shared/demo/sample1.py"
    },
    {
      name       = "demo_notebook2"
      local_path = "notebooks/sample2.py"
    }
  ]
```
### Notebook ACL

Notebook can have one of these permissions:  `CAN_READ`, `CAN_RUN`, `CAN_EDIT`, and `CAN_MANAGE`.

```
notebooks_access_control = [
  {
    group_name       = "<group_name>"
    permission_level = "CAN_MANAGE"
  },
  {
    user_name       = "<user_name>"
    permission_level = "CAN_MANAGE"
  }
]
```

### [Deploy everything(cluster,job, and notebook):](examples/all)

- Try this: If you want to test what resources are getting deployed.

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project'
terraform apply -var='teamid=tryme' -var='prjid=project'
terraform destroy -var='teamid=tryme' -var='prjid=project'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (store remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote
```

- Set below environment variables based on cloud provider.

- Updated `examples` directory with required values.

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)
---

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

If you see error messages. Try running the same the command again.

```
Error: Failed to delete token in Scope <scope name>
```

```
Error: Scope <scope name> does not exist!
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.14 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 0.5.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | >= 0.5.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_cluster.cluster](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/cluster) | resource |
| [databricks_cluster_policy.this](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/cluster_policy) | resource |
| [databricks_group.this](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/group) | resource |
| [databricks_group_member.group_members](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/group_member) | resource |
| [databricks_instance_pool.driver_instance_nodes](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/instance_pool) | resource |
| [databricks_instance_pool.worker_instance_nodes](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/instance_pool) | resource |
| [databricks_instance_profile.shared](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/instance_profile) | resource |
| [databricks_job.existing_cluster_new_job_existing_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/job) | resource |
| [databricks_job.existing_cluster_new_job_new_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/job) | resource |
| [databricks_job.new_cluster_new_job_existing_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/job) | resource |
| [databricks_job.new_cluster_new_job_new_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/job) | resource |
| [databricks_notebook.notebook_file](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/notebook) | resource |
| [databricks_notebook.notebook_file_deployment](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/notebook) | resource |
| [databricks_permissions.cluster](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.driver_pool](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.existing_cluster_new_job_existing_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.existing_cluster_new_job_new_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.jobs_notebook](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.new_cluster_new_job_existing_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.new_cluster_new_job_new_notebooks](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.notebook](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.policy](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_permissions.worker_pool](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/permissions) | resource |
| [databricks_secret_acl.spectators](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/secret_acl) | resource |
| [databricks_user.users](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/user) | resource |
| [databricks_current_user.me](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/data-sources/current_user) | data source |
| [databricks_node_type.cluster_node_type](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/data-sources/node_type) | data source |
| [databricks_spark_version.latest](https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/data-sources/spark_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_instance_profile_to_workspace"></a> [add\_instance\_profile\_to\_workspace](#input\_add\_instance\_profile\_to\_workspace) | Existing AWS instance profile ARN | `bool` | `false` | no |
| <a name="input_allow_cluster_create"></a> [allow\_cluster\_create](#input\_allow\_cluster\_create) | This is a field to allow the group to have cluster create privileges. More fine grained permissions could be assigned with databricks\_permissions and cluster\_id argument. Everyone without allow\_cluster\_create argument set, but with permission to use Cluster Policy would be able to create clusters, but within boundaries of that specific policy. | `bool` | `true` | no |
| <a name="input_allow_instance_pool_create"></a> [allow\_instance\_pool\_create](#input\_allow\_instance\_pool\_create) | This is a field to allow the group to have instance pool create privileges. More fine grained permissions could be assigned with databricks\_permissions and instance\_pool\_id argument. | `bool` | `true` | no |
| <a name="input_always_running"></a> [always\_running](#input\_always\_running) | Whenever the job is always running, like a Spark Streaming application, on every update restart the current active run or start it again, if nothing it is not running. False by default. | `bool` | `false` | no |
| <a name="input_auto_scaling"></a> [auto\_scaling](#input\_auto\_scaling) | Number of min and max workers in auto scale. | `list(any)` | `null` | no |
| <a name="input_aws_attributes"></a> [aws\_attributes](#input\_aws\_attributes) | Optional configuration block contains attributes related to clusters running on AWS. | `any` | `null` | no |
| <a name="input_azure_attributes"></a> [azure\_attributes](#input\_azure\_attributes) | Optional configuration block contains attributes related to clusters running on Azure. | `any` | `null` | no |
| <a name="input_category"></a> [category](#input\_category) | Node category, which can be one of: General purpose, Memory optimized, Storage optimized, Compute optimized, GPU | `string` | `"General purpose"` | no |
| <a name="input_cluster_access_control"></a> [cluster\_access\_control](#input\_cluster\_access\_control) | Cluster access control | `any` | `null` | no |
| <a name="input_cluster_autotermination_minutes"></a> [cluster\_autotermination\_minutes](#input\_cluster\_autotermination\_minutes) | cluster auto termination duration | `number` | `30` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Existing cluster id | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | `null` | no |
| <a name="input_cluster_policy_id"></a> [cluster\_policy\_id](#input\_cluster\_policy\_id) | Exiting cluster policy id | `string` | `null` | no |
| <a name="input_create_group"></a> [create\_group](#input\_create\_group) | Create a new group, if group already exists the deployment will fail. | `bool` | `false` | no |
| <a name="input_create_user"></a> [create\_user](#input\_create\_user) | Create a new user, if user already exists the deployment will fail. | `bool` | `false` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | Extra custom tags | `any` | `null` | no |
| <a name="input_databricks_username"></a> [databricks\_username](#input\_databricks\_username) | User allowed to access the platform. | `string` | `""` | no |
| <a name="input_deploy_cluster"></a> [deploy\_cluster](#input\_deploy\_cluster) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_deploy_cluster_policy"></a> [deploy\_cluster\_policy](#input\_deploy\_cluster\_policy) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_deploy_driver_instance_pool"></a> [deploy\_driver\_instance\_pool](#input\_deploy\_driver\_instance\_pool) | Driver instance pool | `bool` | `false` | no |
| <a name="input_deploy_job_cluster"></a> [deploy\_job\_cluster](#input\_deploy\_job\_cluster) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_deploy_jobs"></a> [deploy\_jobs](#input\_deploy\_jobs) | feature flag, true or false | `bool` | `false` | no |
| <a name="input_deploy_worker_instance_pool"></a> [deploy\_worker\_instance\_pool](#input\_deploy\_worker\_instance\_pool) | Worker instance pool | `bool` | `false` | no |
| <a name="input_driver_node_type_id"></a> [driver\_node\_type\_id](#input\_driver\_node\_type\_id) | The node type of the Spark driver. This field is optional; if unset, API will set the driver node type to the same value as node\_type\_id. | `string` | `null` | no |
| <a name="input_email_notifications"></a> [email\_notifications](#input\_email\_notifications) | Email notification block. | `any` | `null` | no |
| <a name="input_fixed_value"></a> [fixed\_value](#input\_fixed\_value) | Number of nodes in the cluster. | `number` | `0` | no |
| <a name="input_gb_per_core"></a> [gb\_per\_core](#input\_gb\_per\_core) | Number of gigabytes per core available on instance. Conflicts with min\_memory\_gb. Defaults to 0. | `string` | `0` | no |
| <a name="input_gcp_attributes"></a> [gcp\_attributes](#input\_gcp\_attributes) | Optional configuration block contains attributes related to clusters running on GCP. | `any` | `null` | no |
| <a name="input_gpu"></a> [gpu](#input\_gpu) | GPU required or not. | `bool` | `false` | no |
| <a name="input_idle_instance_autotermination_minutes"></a> [idle\_instance\_autotermination\_minutes](#input\_idle\_instance\_autotermination\_minutes) | idle instance auto termination duration | `number` | `20` | no |
| <a name="input_instance_pool_access_control"></a> [instance\_pool\_access\_control](#input\_instance\_pool\_access\_control) | Instance pool access control | `any` | `null` | no |
| <a name="input_jobs_access_control"></a> [jobs\_access\_control](#input\_jobs\_access\_control) | Jobs access control | `any` | `null` | no |
| <a name="input_local_disk"></a> [local\_disk](#input\_local\_disk) | Pick only nodes with local storage. Defaults to false. | `string` | `true` | no |
| <a name="input_local_notebooks"></a> [local\_notebooks](#input\_local\_notebooks) | Local path to the notebook(s) that will be used by the job | `any` | `[]` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | instance pool maximum capacity | `number` | `3` | no |
| <a name="input_max_concurrent_runs"></a> [max\_concurrent\_runs](#input\_max\_concurrent\_runs) | An optional maximum allowed number of concurrent runs of the job. | `number` | `null` | no |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | An optional maximum number of times to retry an unsuccessful run. A run is considered to be unsuccessful if it completes with a FAILED result\_state or INTERNAL\_ERROR life\_cycle\_state. The value -1 means to retry indefinitely and the value 0 means to never retry. The default behavior is to never retry. | `number` | `0` | no |
| <a name="input_min_cores"></a> [min\_cores](#input\_min\_cores) | Minimum number of CPU cores available on instance. Defaults to 0. | `string` | `0` | no |
| <a name="input_min_gpus"></a> [min\_gpus](#input\_min\_gpus) | Minimum number of GPU's attached to instance. Defaults to 0. | `string` | `0` | no |
| <a name="input_min_idle_instances"></a> [min\_idle\_instances](#input\_min\_idle\_instances) | instance pool minimum idle instances | `number` | `1` | no |
| <a name="input_min_memory_gb"></a> [min\_memory\_gb](#input\_min\_memory\_gb) | Minimum amount of memory per node in gigabytes. Defaults to 0. | `string` | `0` | no |
| <a name="input_min_retry_interval_millis"></a> [min\_retry\_interval\_millis](#input\_min\_retry\_interval\_millis) | An optional minimal interval in milliseconds between the start of the failed run and the subsequent retry run. The default behavior is that unsuccessful runs are immediately retried. | `number` | `null` | no |
| <a name="input_ml"></a> [ml](#input\_ml) | ML required or not. | `bool` | `false` | no |
| <a name="input_notebooks"></a> [notebooks](#input\_notebooks) | Local path to the notebook(s) that will be deployed | `any` | `[]` | no |
| <a name="input_notebooks_access_control"></a> [notebooks\_access\_control](#input\_notebooks\_access\_control) | Notebook access control | `any` | `null` | no |
| <a name="input_policy_access_control"></a> [policy\_access\_control](#input\_policy\_access\_control) | Policy access control | `any` | `null` | no |
| <a name="input_policy_overrides"></a> [policy\_overrides](#input\_policy\_overrides) | Cluster policy overrides | `any` | `null` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_remote_notebooks"></a> [remote\_notebooks](#input\_remote\_notebooks) | Path to notebook(s) in the databricks workspace that will be used by the job | `any` | `[]` | no |
| <a name="input_retry_on_timeout"></a> [retry\_on\_timeout](#input\_retry\_on\_timeout) | An optional policy to specify whether to retry a job when it times out. The default behavior is to not retry on timeout. | `bool` | `false` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Job schedule configuration. | `map(any)` | `null` | no |
| <a name="input_spark_conf"></a> [spark\_conf](#input\_spark\_conf) | Map with key-value pairs to fine-tune Spark clusters, where you can provide custom Spark configuration properties in a cluster configuration. | `any` | `null` | no |
| <a name="input_spark_env_vars"></a> [spark\_env\_vars](#input\_spark\_env\_vars) | Map with environment variable key-value pairs to fine-tune Spark clusters. Key-value pairs of the form (X,Y) are exported (i.e., X='Y') while launching the driver and workers. | `any` | `null` | no |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Runtime version of the cluster. Any supported databricks\_spark\_version id. We advise using Cluster Policies to restrict the list of versions for simplicity while maintaining enough control. | `string` | `null` | no |
| <a name="input_task_parameters"></a> [task\_parameters](#input\_task\_parameters) | Base parameters to be used for each run of this job. | `map(any)` | `{}` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | An optional timeout applied to each run of this job. The default behavior is to have no timeout. | `number` | `null` | no |
| <a name="input_worker_node_type_id"></a> [worker\_node\_type\_id](#input\_worker\_node\_type\_id) | The node type of the Spark worker. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | databricks cluster id |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | databricks cluster name |
| <a name="output_cluster_policy_id"></a> [cluster\_policy\_id](#output\_cluster\_policy\_id) | databricks cluster policy permissions |
| <a name="output_databricks_group"></a> [databricks\_group](#output\_databricks\_group) | databricks group name |
| <a name="output_databricks_group_member"></a> [databricks\_group\_member](#output\_databricks\_group\_member) | databricks group members |
| <a name="output_databricks_secret_acl"></a> [databricks\_secret\_acl](#output\_databricks\_secret\_acl) | databricks secret acl |
| <a name="output_databricks_user"></a> [databricks\_user](#output\_databricks\_user) | databricks user name |
| <a name="output_databricks_user_id"></a> [databricks\_user\_id](#output\_databricks\_user\_id) | databricks user id |
| <a name="output_existing_cluster_new_job_existing_notebooks_id"></a> [existing\_cluster\_new\_job\_existing\_notebooks\_id](#output\_existing\_cluster\_new\_job\_existing\_notebooks\_id) | databricks new cluster job id |
| <a name="output_existing_cluster_new_job_existing_notebooks_job"></a> [existing\_cluster\_new\_job\_existing\_notebooks\_job](#output\_existing\_cluster\_new\_job\_existing\_notebooks\_job) | databricks new cluster job url |
| <a name="output_existing_cluster_new_job_new_notebooks_id"></a> [existing\_cluster\_new\_job\_new\_notebooks\_id](#output\_existing\_cluster\_new\_job\_new\_notebooks\_id) | databricks new cluster job id |
| <a name="output_existing_cluster_new_job_new_notebooks_job"></a> [existing\_cluster\_new\_job\_new\_notebooks\_job](#output\_existing\_cluster\_new\_job\_new\_notebooks\_job) | databricks new cluster job url |
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | databricks instance profile ARN |
| <a name="output_new_cluster_new_job_existing_notebooks_id"></a> [new\_cluster\_new\_job\_existing\_notebooks\_id](#output\_new\_cluster\_new\_job\_existing\_notebooks\_id) | databricks job id |
| <a name="output_new_cluster_new_job_existing_notebooks_job"></a> [new\_cluster\_new\_job\_existing\_notebooks\_job](#output\_new\_cluster\_new\_job\_existing\_notebooks\_job) | databricks job url |
| <a name="output_new_cluster_new_job_new_notebooks_id"></a> [new\_cluster\_new\_job\_new\_notebooks\_id](#output\_new\_cluster\_new\_job\_new\_notebooks\_id) | databricks job id |
| <a name="output_new_cluster_new_job_new_notebooks_job"></a> [new\_cluster\_new\_job\_new\_notebooks\_job](#output\_new\_cluster\_new\_job\_new\_notebooks\_job) | databricks job url |
| <a name="output_notebook_url"></a> [notebook\_url](#output\_notebook\_url) | databricks notebook url |
| <a name="output_notebook_url_standalone"></a> [notebook\_url\_standalone](#output\_notebook\_url\_standalone) | databricks notebook url standalone |
<!-- END_TF_DOCS -->
