module "org" {
  source                                  = "../.."
  organization                            = "vmvarela-org-testing"
  name                                    = "Testing"
  company                                 = "Testing Corp."
  email                                   = "vmvarela@gmail.com"
  description                             = "Only tests."
  billing_email                           = "vmvarela@gmail.com"
  location                                = "Spain"
  default_repository_permission           = "none"
  has_organization_projects               = false
  has_repository_projects                 = false
  members_can_create_pages                = false
  members_can_create_private_pages        = false
  members_can_create_private_repositories = false
  members_can_create_public_pages         = false
  members_can_create_public_repositories  = false
  members_can_create_repositories         = false

  blocked = [
    "vmvarela-clb_prisa"
  ]

  webhooks = [
    {
      url          = "https://www.mycompany.com/webhook"
      content_type = "json"
      events       = ["issues"]
    }
  ]

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

  custom_roles = {
    "myrole" = {
      description = "My custom role"
      base_role   = "write"
      permissions = ["remove_assignee"]
    }
  }

  settings = {
    topics = ["terraform-test"]
  }

  repositories = {
    "test-org-simple-1" = {
      topics = ["repo-1-topic"]
    }
    "test-org-simple-2" = {}
    "test-org-simple-3" = {}
  }

  defaults = {
    topics   = ["default-topic"]
    template = "vmvarela/template"
  }
}
