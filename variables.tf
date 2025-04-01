variable "organization" {
  description = "Org name."
  type        = string
  default     = null
}

variable "enterprise" {
  description = "True if the organization is associated with an enterprise account."
  type        = bool
  default     = false
}

variable "billing_email" {
  description = "Billing email address. This address is not publicized."
  type        = string
}

variable "company" {
  description = "The company name."
  type        = string
  default     = null
}

variable "email" {
  description = "The publicly visible email address."
  type        = string
  default     = null
}

variable "twitter_username" {
  description = "The Twitter username of the company."
  type        = string
  default     = null
}

variable "location" {
  description = "The location."
  type        = string
  default     = null
}

variable "name" {
  description = "The shorthand name of the company."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the company. The maximum size is 160 characters."
  type        = string
  default     = null
}

variable "has_organization_projects" {
  description = "Whether an organization can use organization projects."
  type        = bool
  default     = null
}

variable "has_repository_projects" {
  description = "Whether repositories that belong to the organization can use repository projects."
  type        = bool
  default     = null
}

variable "default_repository_permission" {
  description = "Default permission level members have for organization repositories. Can be one of `read`, `write`, `admin`, or `none`."
  type        = string
  default     = null
  validation {
    condition     = var.default_repository_permission == null || can(regex("^read$|^write$|^admin$|^none$", var.default_repository_permission))
    error_message = "Allowed values in default_repository_permission: read, write, admin, or none"
  }
}

variable "members_can_create_repositories" {
  description = "Whether of non-admin organization members can create repositories."
  type        = bool
  default     = null
}

variable "members_can_create_internal_repositories" {
  description = "Whether organization members can create internal repositories, which are visible to all enterprise members. You can only allow members to create internal repositories if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+."
  type        = bool
  default     = null
}

variable "members_can_create_private_repositories" {
  description = "Whether organization members can create private repositories, which are visible to organization members with permission."
  type        = bool
  default     = null
}

variable "members_can_create_public_repositories" {
  description = "Whether organization members can create public repositories, which are visible to anyone."
  type        = bool
  default     = null
}

variable "members_can_create_pages" {
  description = "Whether organization members can create GitHub Pages sites. Existing published sites will not be impacted."
  type        = bool
  default     = null
}

variable "members_can_create_public_pages" {
  description = "Whether organization members can create public GitHub Pages sites. Existing published sites will not be impacted."
  type        = bool
  default     = null
}

variable "members_can_create_private_pages" {
  description = "Whether organization members can create private GitHub Pages sites. Existing published sites will not be impacted."
  type        = bool
  default     = null
}

variable "members_can_fork_private_repositories" {
  description = "Whether organization members can fork private organization repositories."
  type        = bool
  default     = null
}

variable "web_commit_signoff_required" {
  description = "Whether contributors to organization repositories are required to sign off on commits they make through GitHub's web interface."
  type        = bool
  default     = null
}

variable "blog" {
  description = "URL of organization blog"
  type        = string
  default     = null
}

variable "enable_advanced_security" {
  description = "Use to enable or disable GitHub Advanced Security for new repositories."
  type        = bool
  default     = null
}

variable "enable_secret_scanning" {
  description = "Use to enable or disable secret scanning for new repositories."
  type        = bool
  default     = null
}

variable "enable_secret_scanning_push_protection" {
  description = "Use to enable or disable secret scanning push protection for new repositories. If set to `true`, the repository's visibility must be `public` or `enable_advanced_security` must also be `true`."
  type        = bool
  default     = null
}

variable "enable_vulnerability_alerts" {
  description = "Either `true` to enable vulnerability alerts, or `false` to disable vulnerability alerts for new repositories."
  type        = bool
  default     = null
}

variable "enable_dependabot_security_updates" {
  description = "Set to `true` to enable the automated security fixes for new repositories."
  type        = bool
  default     = null
}

variable "blocked" {
  description = "allows you to create and manage blocks for GitHub organizations."
  type        = set(string)
  default     = null
}

variable "webhooks" {
  description = "The list of webhooks of the organization. See webhook sub-module for details."
  type        = any
  default     = {}
}

variable "variables" {
  description = "The list of variables configuration of the organization (key: variable_name)"
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
  description = "The list of secrets configuration of the organization (key: secret_name)"
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

variable "secrets_encrypted" {
  description = "The list of secrets configuration of the organization (key: secret_name)"
  type = map(object({
    encrypted_value = optional(string, null)
    plaintext_value = optional(string, null)
    visibility      = optional(string, null)
    repositories    = optional(set(string), [])
  }))
  default = {}
  validation {
    condition     = alltrue([for var, config in(var.secrets_encrypted == null ? {} : var.secrets_encrypted) : contains(["all", "private", "selected"], config.visibility)])
    error_message = "Possible values for visibility are `all`, `private` or `selected`."
  }
}

variable "dependabot_copy_secrets" {
  description = "If dependabot uses same repository secrets (plaintext or encrypted). Makes a copy."
  type        = bool
  default     = false
}

variable "dependabot_secrets" {
  description = "The list of dependabot secrets configuration of the organization (key: secret_name)"
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

variable "dependabot_secrets_encrypted" {
  description = "The list of dependabot secrets configuration of the organization (key: secret_name)"
  type = map(object({
    encrypted_value = optional(string, null)
    plaintext_value = optional(string, null)
    visibility      = optional(string, null)
    repositories    = optional(set(string), [])
  }))
  default = {}
  validation {
    condition     = alltrue([for var, config in(var.dependabot_secrets_encrypted == null ? {} : var.dependabot_secrets_encrypted) : contains(["all", "private", "selected"], config.visibility)])
    error_message = "Possible values for visibility are `all`, `private` or `selected`."
  }
}

variable "rulesets" {
  description = "Organization rules"
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
  description = "The list of custom roles of the organization (key: role_name)"
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
  description = "The list of runner groups of the organization (key: runner_group_name)"
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
  description = "Repositories default configuration (if empty)"
  type        = any
  default     = {}
}

variable "repositories" {
  description = "Repositories"
  type        = any
  default     = {}
}

variable "settings" {
  description = "Repositories fixed common configuration (cannot be overwritten)"
  type        = any
  default     = {}
}
