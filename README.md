# GitHub Org Terraform module

A Terraform module for comprehensive GitHub organization management. This module enables Infrastructure as Code (IaC) practices for GitHub organization administration, providing complete control over organization settings, members, teams, and security configurations.

The module offers seamless management of key organizational resources including:
- Organization settings and profile configuration
- Member management with role-based access control
- Team creation and membership administration
- GitHub Actions organization-level permissions and configuration
- Secrets and variables management across the organization
- Security policy enforcement and advanced security features
- Webhook integration for organization events
- Custom roles and permissions management
- Organization-wide project administration
- Repository creation templates and default settings

Designed for DevOps teams seeking to standardize GitHub organization management through code, this module supports comprehensive governance while maintaining flexibility for organization-specific requirements.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_organization_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret) | resource |
| [github_actions_organization_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_runner_group.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_runner_group) | resource |
| [github_dependabot_organization_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_organization_secret) | resource |
| [github_organization_block.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_block) | resource |
| [github_organization_custom_role.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_custom_role) | resource |
| [github_organization_ruleset.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_ruleset) | resource |
| [github_organization_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings) | resource |
| [github_organization_webhook.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_webhook) | resource |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |
| [github_organization_teams.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization_teams) | data source |
| [github_repositories.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repositories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_email"></a> [billing\_email](#input\_billing\_email) | (Required) Billing email address. This address is not publicized. | `string` | n/a | yes |
| <a name="input_blocked"></a> [blocked](#input\_blocked) | (Optional) allows you to create and manage blocks for GitHub organizations. | `set(string)` | `null` | no |
| <a name="input_blog"></a> [blog](#input\_blog) | (Optional) URL of organization blog | `string` | `null` | no |
| <a name="input_company"></a> [company](#input\_company) | (Optional) The company name. | `string` | `null` | no |
| <a name="input_custom_roles"></a> [custom\_roles](#input\_custom\_roles) | (Optional) The list of custom roles of the organization (key: role\_name) | <pre>map(object({<br/>    description = optional(string)<br/>    base_role   = string<br/>    permissions = set(string)<br/>  }))</pre> | `null` | no |
| <a name="input_default_repository_permission"></a> [default\_repository\_permission](#input\_default\_repository\_permission) | (Optional) Default permission level members have for organization repositories. Can be one of `read`, `write`, `admin`, or `none`. | `string` | `null` | no |
| <a name="input_dependabot_secrets"></a> [dependabot\_secrets](#input\_dependabot\_secrets) | (Optional) The list of dependabot secrets configuration of the organization (key: secret\_name) | <pre>map(object({<br/>    encrypted_value = optional(string, null)<br/>    plaintext_value = optional(string, null)<br/>    visibility      = optional(string, null)<br/>    repositories    = optional(set(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the company. The maximum size is 160 characters. | `string` | `null` | no |
| <a name="input_email"></a> [email](#input\_email) | (Optional) The publicly visible email address. | `string` | `null` | no |
| <a name="input_enable_advanced_security"></a> [enable\_advanced\_security](#input\_enable\_advanced\_security) | (Optional) Use to enable or disable GitHub Advanced Security for new repositories. | `bool` | `null` | no |
| <a name="input_enable_dependabot_security_updates"></a> [enable\_dependabot\_security\_updates](#input\_enable\_dependabot\_security\_updates) | (Optional) Set to `true` to enable the automated security fixes for new repositories. | `bool` | `null` | no |
| <a name="input_enable_secret_scanning"></a> [enable\_secret\_scanning](#input\_enable\_secret\_scanning) | (Optional) Use to enable or disable secret scanning for new repositories. | `bool` | `null` | no |
| <a name="input_enable_secret_scanning_push_protection"></a> [enable\_secret\_scanning\_push\_protection](#input\_enable\_secret\_scanning\_push\_protection) | (Optional) Use to enable or disable secret scanning push protection for new repositories. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`. | `bool` | `null` | no |
| <a name="input_enable_vulnerability_alerts"></a> [enable\_vulnerability\_alerts](#input\_enable\_vulnerability\_alerts) | (Optional) Either `true` to enable vulnerability alerts, or `false` to disable vulnerability alerts for new repositories. | `bool` | `null` | no |
| <a name="input_enterprise"></a> [enterprise](#input\_enterprise) | (Optional) True if the organization is associated with an enterprise account. | `bool` | `false` | no |
| <a name="input_has_organization_projects"></a> [has\_organization\_projects](#input\_has\_organization\_projects) | (Optional) Whether an organization can use organization projects. | `bool` | `null` | no |
| <a name="input_has_repository_projects"></a> [has\_repository\_projects](#input\_has\_repository\_projects) | (Optional) Whether repositories that belong to the organization can use repository projects. | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The location. | `string` | `null` | no |
| <a name="input_members_can_create_internal_repositories"></a> [members\_can\_create\_internal\_repositories](#input\_members\_can\_create\_internal\_repositories) | (Optional) Whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. | `bool` | `null` | no |
| <a name="input_members_can_create_pages"></a> [members\_can\_create\_pages](#input\_members\_can\_create\_pages) | (Optional) Whether organization members can create GitHub Pages sites. Existing published sites will not be impacted. | `bool` | `null` | no |
| <a name="input_members_can_create_private_pages"></a> [members\_can\_create\_private\_pages](#input\_members\_can\_create\_private\_pages) | (Optional) Whether organization members can create private GitHub Pages sites. Existing published sites will not be impacted. | `bool` | `null` | no |
| <a name="input_members_can_create_private_repositories"></a> [members\_can\_create\_private\_repositories](#input\_members\_can\_create\_private\_repositories) | (Optional) Whether organization members can create private repositories, which are visible to organization members with permission. | `bool` | `null` | no |
| <a name="input_members_can_create_public_pages"></a> [members\_can\_create\_public\_pages](#input\_members\_can\_create\_public\_pages) | (Optional) Whether organization members can create public GitHub Pages sites. Existing published sites will not be impacted. | `bool` | `null` | no |
| <a name="input_members_can_create_public_repositories"></a> [members\_can\_create\_public\_repositories](#input\_members\_can\_create\_public\_repositories) | (Optional) Whether organization members can create public repositories, which are visible to anyone. | `bool` | `null` | no |
| <a name="input_members_can_create_repositories"></a> [members\_can\_create\_repositories](#input\_members\_can\_create\_repositories) | (Optional) Whether of non-admin organization members can create repositories. | `bool` | `null` | no |
| <a name="input_members_can_fork_private_repositories"></a> [members\_can\_fork\_private\_repositories](#input\_members\_can\_fork\_private\_repositories) | (Optional) Whether organization members can fork private organization repositories. | `bool` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The shorthand name of the company. | `string` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | (Required) Org name. | `string` | `false` | no |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | (Optional) Organization rules | <pre>map(object({<br/>    enforcement = optional(string, "active")<br/>    rules = optional(object({<br/>      branch_name_pattern = optional(object({<br/>        operator = optional(string)<br/>        pattern  = optional(string)<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      commit_author_email_pattern = optional(object({<br/>        operator = optional(string)<br/>        pattern  = optional(string)<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      commit_message_pattern = optional(object({<br/>        operator = optional(string)<br/>        pattern  = optional(string)<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      committer_email_pattern = optional(object({<br/>        operator = optional(string)<br/>        pattern  = optional(string)<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      creation         = optional(bool)<br/>      deletion         = optional(bool)<br/>      non_fast_forward = optional(bool)<br/>      pull_request = optional(object({<br/>        dismiss_stale_reviews_on_push     = optional(bool)<br/>        require_code_owner_review         = optional(bool)<br/>        require_last_push_approval        = optional(bool)<br/>        required_approving_review_count   = optional(number)<br/>        required_review_thread_resolution = optional(bool)<br/>      }))<br/>      required_workflows = optional(list(object({<br/>        repository = string<br/>        path       = string<br/>        ref        = optional(string)<br/>      })))<br/>      required_linear_history              = optional(bool)<br/>      required_signatures                  = optional(bool)<br/>      required_status_checks               = optional(map(string))<br/>      strict_required_status_checks_policy = optional(bool)<br/>      tag_name_pattern = optional(object({<br/>        operator = optional(string)<br/>        pattern  = optional(string)<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      update = optional(bool)<br/>    }))<br/>    target = optional(string, "branch")<br/>    bypass_actors = optional(map(object({<br/>      actor_type  = string<br/>      bypass_mode = string<br/>    })))<br/>    include      = optional(list(string), [])<br/>    exclude      = optional(list(string), [])<br/>    repositories = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_runner_groups"></a> [runner\_groups](#input\_runner\_groups) | (Optional) The list of runner groups of the organization (key: runner\_group\_name) | <pre>map(object({<br/>    visibility                = optional(string, null)<br/>    workflows                 = optional(set(string))<br/>    repositories              = optional(set(string), [])<br/>    allow_public_repositories = optional(bool)<br/>  }))</pre> | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | (Optional) The list of secrets configuration of the organization (key: secret\_name) | <pre>map(object({<br/>    encrypted_value = optional(string, null)<br/>    plaintext_value = optional(string, null)<br/>    visibility      = optional(string, null)<br/>    repositories    = optional(set(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_twitter_username"></a> [twitter\_username](#input\_twitter\_username) | (Optional) The Twitter username of the company. | `string` | `null` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | (Optional) The list of variables configuration of the organization (key: variable\_name) | <pre>map(object({<br/>    value        = optional(string, null)<br/>    visibility   = optional(string, null)<br/>    repositories = optional(set(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | (Optional) Whether contributors to organization repositories are required to sign off on commits they make through GitHub's web interface. | `bool` | `null` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | (Optional) The list of webhooks of the organization (key: webhook\_url) | <pre>map(object({<br/>    content_type = string<br/>    insecure_ssl = optional(bool, false)<br/>    secret       = optional(string)<br/>    events       = optional(list(string))<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Github Organization ID |
| <a name="output_organization"></a> [organization](#output\_organization) | Organization data |
| <a name="output_repositories"></a> [repositories](#output\_repositories) | All repository IDs |
| <a name="output_teams"></a> [teams](#output\_teams) | Team data |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Victor M. Varela](https://github.com/vmvarela).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/vmvarela/terraform-github-org/tree/master/LICENSE) for full details.
