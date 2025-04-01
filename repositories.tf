module "sub" {
  source       = "vmvarela/suborg/github"
  settings     = var.settings
  defaults     = var.defaults
  repositories = var.repositories
}
