# organization_webhook
resource "github_organization_webhook" "this" {
  active = true
  configuration {
    url          = var.url
    content_type = var.content_type
    insecure_ssl = var.insecure_ssl
    secret       = var.secret
  }
  events = var.events
}
