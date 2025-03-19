data "github_repositories" "this" {
  query           = "org:${var.organization}"
  include_repo_id = true
}

# teams
data "github_organization" "this" {
  name = var.organization
}

# teams
data "github_organization_teams" "this" {
  summary_only = true
}
