module "sub" {
  source       = "vmvarela/suborg/github"
  version      = "0.2.1"
  settings     = var.settings
  defaults     = var.defaults
  repositories = var.repositories
}
