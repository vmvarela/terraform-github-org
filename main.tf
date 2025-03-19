# actions_organization_permissions

# actions_organization_secrets
resource "github_actions_organization_secret" "this" {
  for_each                = var.secrets != null ? var.secrets : {}
  secret_name             = each.key
  plaintext_value         = each.value.plaintext_value
  encrypted_value         = each.value.encrypted_value
  visibility              = each.value.visibility
  selected_repository_ids = each.value.visibility == "selected" ? [for r in each.value.repositories : data.github_repository.this[r].repo_id] : null
}

# actions_organization_variable
resource "github_actions_organization_variable" "this" {
  for_each                = var.variables != null ? var.variables : {}
  variable_name           = each.key
  value                   = each.value.value
  visibility              = each.value.visibility
  selected_repository_ids = each.value.visibility == "selected" ? [for r in each.value.repositories : data.github_repository.this[r].repo_id] : null
}

# actions_runner_group

# dependabot_organization_secret
resource "github_dependabot_organization_secret" "this" {
  for_each                = var.dependabot_secrets != null ? var.dependabot_secrets : {}
  secret_name             = each.key
  plaintext_value         = each.value.plaintext_value
  encrypted_value         = each.value.encrypted_value
  visibility              = each.value.visibility
  selected_repository_ids = each.value.visibility == "selected" ? [for r in each.value.repositories : data.github_repository.this[r].repo_id] : null
}

# membership
resource "github_membership" "this" {
  for_each = var.members != null ? var.members : {}
  username = each.key
  role     = each.value
}

# organization_block
resource "github_organization_block" "this" {
  for_each = var.blocked != null ? var.blocked : []
  username = each.value
}

# organization_custom_role


# organization_ruleset
# resource "github_organization_ruleset" "this" {
#   for_each    = var.rulesets != null ? var.rulesets : {}
#   name        = each.key
#   enforcement = each.value.enforcement
#   target      = each.value.target
#
#   dynamic "conditions" {
#     for_each = (length(each.value.include) + length(each.value.exclude) > 0) ? [1] : []
#     content {
#       ref_name {
#         include = [for p in each.value.include :
#           substr(p, 0, 1) == "~" ? p : format("refs/%s/%s", each.value.target == "branch" ? "heads" : "tags", p)
#         ]
#         exclude = [for p in each.value.exclude :
#           substr(p, 0, 1) == "~" ? p : format("refs/%s/%s", each.value.target == "branch" ? "heads" : "tags", p)
#         ]
#       }
#     }
#   }
#
#   dynamic "bypass_actors" {
#     for_each = (each.value.bypass_roles != null) ? each.value.bypass_roles : []
#     content {
#       actor_type  = "RepositoryRole"
#       actor_id    = lookup(local.repository_roles, bypass_actors.value, null)
#       bypass_mode = each.value.bypass_mode
#     }
#   }
#   dynamic "bypass_actors" {
#     for_each = (each.value.bypass_teams != null) ? each.value.bypass_teams : []
#     content {
#       actor_type  = "Team"
#       actor_id    = bypass_actors.value
#       bypass_mode = each.value.bypass_mode
#     }
#   }
#   dynamic "bypass_actors" {
#     for_each = (each.value.bypass_integration != null) ? each.value.bypass_integration : []
#     content {
#       actor_type  = "Integration"
#       actor_id    = bypass_actors.value
#       bypass_mode = each.value.bypass_mode
#     }
#   }
#   dynamic "bypass_actors" {
#     for_each = each.value.bypass_organization_admin == true ? [1] : []
#     content {
#       actor_type  = "OrganizationAdmin"
#       actor_id    = 0 # admin
#       bypass_mode = each.value.bypass_mode
#     }
#   }
#
#   rules {
#     dynamic "branch_name_pattern" {
#       for_each = try(each.value.regex_branch_name, null) != null ? [1] : []
#       content {
#         operator = "regex"
#         pattern  = each.value.regex_branch_name
#       }
#     }
#     dynamic "tag_name_pattern" {
#       for_each = try(each.value.regex_tag_name, null) != null ? [1] : []
#       content {
#         operator = "regex"
#         pattern  = each.value.regex_tag_name
#       }
#     }
#     dynamic "commit_author_email_pattern" {
#       for_each = try(each.value.regex_commit_author_email, null) != null ? [1] : []
#       content {
#         operator = "regex"
#         pattern  = each.value.each.value.regex_commit_author_email
#       }
#     }
#     dynamic "commit_message_pattern" {
#       for_each = try(each.value.regex_commit_message, null) != null ? [1] : []
#       content {
#         operator = "regex"
#         pattern  = each.value.regex_commit_message
#       }
#     }
#     dynamic "committer_email_pattern" {
#       for_each = try(each.value.regex_committer_email, null) != null ? [1] : []
#       content {
#         operator = "regex"
#         pattern  = each.value.regex_committer_email
#       }
#     }
#
#     creation         = each.value.forbidden_creation
#     deletion         = each.value.forbidden_deletion
#     update           = each.value.forbidden_update
#     non_fast_forward = each.value.forbidden_fast_forward
#
#     dynamic "pull_request" {
#       for_each = try(each.value.rules.pull_request, null) != null ? [1] : []
#       content {
#         dismiss_stale_reviews_on_push     = each.value.dismiss_pr_stale_reviews_on_push
#         require_code_owner_review         = each.value.required_pr_code_owner_review
#         require_last_push_approval        = each.value.required_pr_last_push_approval
#         required_approving_review_count   = each.value.required_pr_approving_review_count
#         required_review_thread_resolution = each.value.required_pr_review_thread_resolution
#       }
#     }
#     dynamic "required_workflows" {
#       for_each = (each.value.required_workflows != null) ? [1] : []
#       content {
#         dynamic "required_workflow" {
#           for_each = (each.value.required_workflows != null) ? each.value.required_workflows : []
#           content {
#             #repository_id = data.github_repository.this[regex("^([^/]+)", required_workflow.value)].repo_id
#             repository_id = regex("^([^/]+)", required_workflow.value)
#             path          = regex("/(.+?)(?:@|$)", required_workflow.value)
#             ref           = try(regex("@(.+)$", required_workflow.value), null)
#           }
#         }
#       }
#     }
#     required_linear_history = each.value.required_linear_history
#     required_signatures     = each.value.required_signatures
#     dynamic "required_status_checks" {
#       for_each = (each.value.required_checks != null) ? [1] : []
#       content {
#         dynamic "required_check" {
#           for_each = each.value.rules.required_status_checks
#           content {
#             context = required_check.value
#           }
#         }
#       }
#     }
#   }
# }
#

# organization_security_manager

# organization_settings
resource "github_organization_settings" "this" {
  billing_email                            = var.billing_email
  company                                  = var.company
  blog                                     = var.blog
  email                                    = var.email
  twitter_username                         = var.twitter_username
  location                                 = var.location
  name                                     = var.name
  description                              = var.description
  has_organization_projects                = var.has_organization_projects
  has_repository_projects                  = var.has_repository_projects
  default_repository_permission            = var.default_repository_permission
  members_can_create_repositories          = var.members_can_create_repositories
  members_can_create_public_repositories   = var.members_can_create_public_repositories
  members_can_create_private_repositories  = var.members_can_create_private_repositories
  members_can_create_internal_repositories = var.members_can_create_internal_repositories
  members_can_create_pages                 = var.members_can_create_pages
  members_can_create_public_pages          = var.members_can_create_public_pages
  members_can_create_private_pages         = var.members_can_create_private_pages
  members_can_fork_private_repositories    = var.members_can_fork_private_repositories
  web_commit_signoff_required              = var.web_commit_signoff_required
}

# organization_webhook
resource "github_organization_webhook" "this" {
  for_each = var.webhooks != null ? var.webhooks : {}
  active   = true
  configuration {
    url          = each.key
    content_type = each.value.content_type
    insecure_ssl = each.value.insecure_ssl
    secret       = each.value.secret
  }
  events = each.value.events
}

# team

# team_members

# team_settings
