
module "webhook" {
  for_each     = { for w in var.webhooks : sha1(try(w.url, "_default_")) => w }
  source       = "./modules/webhook"
  url          = each.value.url
  events       = try(each.value.events, [])
  content_type = try(each.value.content_type, "form")
  insecure_ssl = try(each.value.insecure_ssl, false)
  secret       = try(each.value.secret, null)
}
