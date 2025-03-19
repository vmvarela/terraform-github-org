data "github_repository" "this" {
  for_each = toset(setunion(
    flatten([for k, config in var.variables : config.repositories if length(config.repositories) > 0]),
    flatten([for k, config in var.secrets : config.repositories if length(config.repositories) > 0]),
    flatten([for k, config in var.dependabot_secrets : config.repositories if length(config.repositories) > 0]),
    flatten([for k, config in var.rulesets : [for r in config.required_workflows : regex("^([^/]+)", r) if length(config.required_workflows) > 0]])
  ))
  name = each.key
}
