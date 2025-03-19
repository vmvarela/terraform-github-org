module "org" {
  source                                  = "../.."
  name                                    = "Testing"
  company                                 = "Testing Corp."
  email                                   = "vmvarela@gmail.com"
  description                             = "Only tests."
  billing_email                           = "vmvarela@gmail.com"
  location                                = "Spain"
  default_repository_permission           = "none"
  has_repository_projects                 = false
  members_can_create_pages                = false
  members_can_create_private_pages        = false
  members_can_create_private_repositories = false
  members_can_create_public_pages         = false
  members_can_create_public_repositories  = false
  members_can_create_repositories         = false

  members = {
    vmvarela = "admin"
  }

  blocked = [
    "vmvarela-clb_prisa"
  ]

  webhooks = {
    "https://www.mycompany.com/webhook" = {
      content_type = "json"
      events       = ["issues"]
    }
  }

  variables = {
    "VAR" = {
      value      = "VAL"
      visibility = "all"
      # repositories = [
      #   "test-2"
      # ]
    }
  }

  secrets = {
    "SECRET" = {
      plaintext_value = "SECRET_VAL"
      visibility      = "selected"
      # repositories    = ["test-1"]
    }
  }

  dependabot_secrets = {
    "DBOT_SECRET" = {
      plaintext_value = "DBOT_SECRET_VAL"
      visibility      = "selected"
      # repositories    = ["test-2"]
    }
  }

  rulesets = {
    test = {
      target  = "branch"
      include = ["~ALL"]
      required_workflows = [
        "test-1/.github/workflows/test.yaml"
      ]
      forbidden_deletion = true
    }

  }
}
