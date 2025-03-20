module "sub" {
  source       = "vmvarela/suborg/github"
  version      = "0.1.2"
  settings     = var.settings
  defaults     = var.defaults
  repositories = var.repositories
}
