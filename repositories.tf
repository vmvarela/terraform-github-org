module "sub" {
  source       = "vmvarela/suborg/github"
  version      = "0.2.0"
  settings     = var.settings
  defaults     = var.defaults
  repositories = var.repositories
}
