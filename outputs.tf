output "id" {
  description = "Github Organization ID"
  value       = github_organization_settings.this.id
}

output "repositories" {
  description = "All repository IDs"
  value       = data.github_repositories.this
}

output "organization" {
  description = "Organization data"
  value       = data.github_organization.this
}

output "teams" {
  description = "Team data"
  value       = data.github_organization_teams.this
}
