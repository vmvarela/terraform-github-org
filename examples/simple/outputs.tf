output "repositories_count" {
  description = "Number of repositories"
  value       = length(module.org.repositories.names)
}

output "teams_count" {
  description = "Number of teams"
  value       = length(module.org.teams.teams)
}

output "members_count" {
  description = "Number of members"
  value       = length(module.org.organization.users)
}
