output "id" {
  description = "Github Organization ID"
  value       = github_organization_settings.this.id
}

output "used" {
  description = "Recovered repository IDs"
  value       = keys(data.github_repository.this)
}
