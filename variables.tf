variable "organization" {
  description = "(Required) Org name."
  type        = string
  default     = false
}

variable "enterprise" {
  description = "(Optional) True if the organization is associated with an enterprise account."
  type        = bool
  default     = false
}

variable "billing_email" {
  description = "(Required) Billing email address. This address is not publicized."
  type        = string
}

variable "company" {
  description = "(Optional) The company name."
  type        = string
  default     = null
}

variable "email" {
  description = "(Optional) The publicly visible email address."
  type        = string
  default     = null
}

variable "twitter_username" {
  description = "(Optional) The Twitter username of the company."
  type        = string
  default     = null
}

variable "location" {
  description = "(Optional) The location."
  type        = string
  default     = null
}

variable "name" {
  description = "(Optional) The shorthand name of the company."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) The description of the company. The maximum size is 160 characters."
  type        = string
  default     = null
}

variable "has_organization_projects" {
  description = "(Optional) Whether an organization can use organization projects."
  type        = bool
  default     = null
}

variable "has_repository_projects" {
  description = "(Optional) Whether repositories that belong to the organization can use repository projects."
  type        = bool
  default     = null
}

variable "default_repository_permission" {
  description = "(Optional) Default permission level members have for organization repositories. Can be one of `read`, `write`, `admin`, or `none`."
  type        = string
  default     = null
  validation {
    condition     = var.default_repository_permission == null || can(regex("^read$|^write$|^admin$|^none$", var.default_repository_permission))
    error_message = "Allowed values in default_repository_permission: read, write, admin, or none"
  }
}

variable "members_can_create_repositories" {
  description = "(Optional) Whether of non-admin organization members can create repositories."
  type        = bool
  default     = null
}

variable "members_can_create_internal_repositories" {
  description = "(Optional) Whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+."
  type        = bool
  default     = null
}

variable "members_can_create_private_repositories" {
  description = "(Optional) Whether organization members can create private repositories, which are visible to organization members with permission."
  type        = bool
  default     = null
}

variable "members_can_create_public_repositories" {
  description = "(Optional) Whether organization members can create public repositories, which are visible to anyone."
  type        = bool
  default     = null
}

variable "members_can_create_pages" {
  description = "(Optional) Whether organization members can create GitHub Pages sites. Existing published sites will not be impacted."
  type        = bool
  default     = null
}

variable "members_can_create_public_pages" {
  description = "(Optional) Whether organization members can create public GitHub Pages sites. Existing published sites will not be impacted."
  type        = bool
  default     = null
}

variable "members_can_create_private_pages" {
  description = "(Optional) Whether organization members can create private GitHub Pages sites. Existing published sites will not be impacted."
  type        = bool
  default     = null
}

variable "members_can_fork_private_repositories" {
  description = "(Optional) Whether organization members can fork private organization repositories."
  type        = bool
  default     = null
}

variable "web_commit_signoff_required" {
  description = "(Optional) Whether contributors to organization repositories are required to sign off on commits they make through GitHub's web interface."
  type        = bool
  default     = null
}

variable "blog" {
  description = "(Optional) URL of organization blog"
  type        = string
  default     = null
}

variable "enable_advanced_security" {
  description = "(Optional) Use to enable or disable GitHub Advanced Security for new repositories."
  type        = bool
  default     = null
}

variable "enable_secret_scanning" {
  description = "(Optional) Use to enable or disable secret scanning for new repositories."
  type        = bool
  default     = null
}

variable "enable_secret_scanning_push_protection" {
  description = "(Optional) Use to enable or disable secret scanning push protection for new repositories. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`."
  type        = bool
  default     = null
}

variable "enable_vulnerability_alerts" {
  description = "(Optional) Either `true` to enable vulnerability alerts, or `false` to disable vulnerability alerts for new repositories."
  type        = bool
  default     = null
}

variable "enable_dependabot_security_updates" {
  description = "(Optional) Set to `true` to enable the automated security fixes for new repositories."
  type        = bool
  default     = null
}

# variable "members" {
#   description = "(Optional) allows you to add/remove users from your organization. When applied, an invitation will be sent to the user to become part of the organization. When destroyed, either the invitation will be cancelled or the user will be removed."
#   type        = map(string)
#   default     = null
#   validation {
#     condition     = alltrue([for username, role in(var.members == null ? {} : var.members) : contains(["member", "admin"], role)])
#     error_message = "Possible values for member role are `member` or `admin`"
#   }
# }

variable "blocked" {
  description = "(Optional) allows you to create and manage blocks for GitHub organizations."
  type        = set(string)
  default     = null
}

variable "webhooks" {
  description = "(Optional) The list of webhooks of the organization (key: webhook_url)"
  type = map(object({
    content_type = string
    insecure_ssl = optional(bool, false)
    secret       = optional(string)
    events       = optional(list(string))
  }))
  default = null
  validation {
    condition     = alltrue([for url, config in(var.webhooks == null ? {} : var.webhooks) : contains(["form", "json"], config.content_type)])
    error_message = "Possible values for content_type are json or form."
  }
}

variable "variables" {
  description = "(Optional) The list of variables configuration of the organization (key: variable_name)"
  type = map(object({
    value        = optional(string, null)
    visibility   = optional(string, null)
    repositories = optional(set(string), [])
  }))
  default = {}
  validation {
    condition     = alltrue([for var, config in(var.variables == null ? {} : var.variables) : contains(["all", "private", "selected"], config.visibility)])
    error_message = "Possible values for visibility are `all`, `private` or `selected`."
  }
}

variable "secrets" {
  description = "(Optional) The list of secrets configuration of the organization (key: secret_name)"
  type = map(object({
    encrypted_value = optional(string, null)
    plaintext_value = optional(string, null)
    visibility      = optional(string, null)
    repositories    = optional(set(string), [])
  }))
  default = {}
  validation {
    condition     = alltrue([for var, config in(var.secrets == null ? {} : var.secrets) : contains(["all", "private", "selected"], config.visibility)])
    error_message = "Possible values for visibility are `all`, `private` or `selected`."
  }
}

variable "dependabot_secrets" {
  description = "(Optional) The list of dependabot secrets configuration of the organization (key: secret_name)"
  type = map(object({
    encrypted_value = optional(string, null)
    plaintext_value = optional(string, null)
    visibility      = optional(string, null)
    repositories    = optional(set(string), [])
  }))
  default = {}
  validation {
    condition     = alltrue([for var, config in(var.dependabot_secrets == null ? {} : var.dependabot_secrets) : contains(["all", "private", "selected"], config.visibility)])
    error_message = "Possible values for visibility are `all`, `private` or `selected`."
  }
}

variable "rulesets" {
  description = "(Optional) Organization rules"
  type = map(object({
    enforcement = optional(string, "active")
    rules = optional(object({
      branch_name_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_author_email_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_message_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      committer_email_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      creation         = optional(bool)
      deletion         = optional(bool)
      non_fast_forward = optional(bool)
      pull_request = optional(object({
        dismiss_stale_reviews_on_push     = optional(bool)
        require_code_owner_review         = optional(bool)
        require_last_push_approval        = optional(bool)
        required_approving_review_count   = optional(number)
        required_review_thread_resolution = optional(bool)
      }))
      required_workflows = optional(list(object({
        repository = string
        path       = string
        ref        = optional(string)
      })))
      required_linear_history              = optional(bool)
      required_signatures                  = optional(bool)
      required_status_checks               = optional(map(string))
      strict_required_status_checks_policy = optional(bool)
      tag_name_pattern = optional(object({
        operator = optional(string)
        pattern  = optional(string)
        name     = optional(string)
        negate   = optional(bool)
      }))
      update = optional(bool)
    }))
    target = optional(string, "branch")
    bypass_actors = optional(map(object({
      actor_type  = string
      bypass_mode = string
    })))
    include      = optional(list(string), [])
    exclude      = optional(list(string), [])
    repositories = optional(list(string))
  }))
  default = {}
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["active", "evaluate", "disabled"], config.enforcement)])
    error_message = "Possible values for enforcement are active, evaluate or disabled."
  }
  validation {
    condition     = alltrue([for name, config in(var.rulesets == null ? {} : var.rulesets) : contains(["tag", "branch"], config.target)])
    error_message = "Possible values for ruleset target are tag or branch"
  }
}

variable "custom_roles" {
  description = "(Optional) The list of custom roles of the organization (key: role_name)"
  type = map(object({
    description = optional(string)
    base_role   = string
    permissions = set(string)
  }))
  default = null
  validation {
    condition     = alltrue([for role, config in(var.custom_roles == null ? {} : var.custom_roles) : contains(["read", "triage", "write", "maintain"], config.base_role)])
    error_message = "Possible values for base_role are read, triage, write or maintain."
  }
}

variable "runner_groups" {
  description = "(Optional) The list of runner groups of the organization (key: runner_group_name)"
  type = map(object({
    visibility                = optional(string, null)
    workflows                 = optional(set(string))
    repositories              = optional(set(string), [])
    allow_public_repositories = optional(bool)
  }))
  default = {}
  validation {
    condition     = alltrue([for rg, config in(var.runner_groups == null ? {} : var.runner_groups) : contains(["all", "private", "selected"], config.visibility)])
    error_message = "Possible values for visibility are `all`, `private` or `selected`."
  }
}

variable "defaults" {
  description = "(Optional) Repositories default configuration (if empty)"
  type        = any
  default     = {}
}

variable "repositories" {
  description = "(Optional) Repositories"
  type        = any
  default     = {}
}

variable "settings" {
  description = "(Optional) Repositories fixed common configuration (cannot be overwritten)"
  type        = any
  default     = {}
}
