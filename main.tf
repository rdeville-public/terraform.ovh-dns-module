resource "ovh_domain_zone_record" "this" {
  for_each = local.zone_records

  zone      = data.ovh_domain_zone.this.name
  subdomain = each.value.subdomain
  target    = each.value.target
  fieldtype = each.value.type
  ttl       = each.value.ttl
}
