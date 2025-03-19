locals {
  # reposity id from a repository name
  repository_id = { for r in data.github_repositories.this.names :
    r => element(data.github_repositories.this.repo_ids, index(data.github_repositories.this.names, r))
  }
}
