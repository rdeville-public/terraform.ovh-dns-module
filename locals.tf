locals {
  // Add parent namespace_id to the repo if namespace_parent name is provided
  zone_records = merge([
    for subdomain, record in var.record : {
      for target, cfg in record :
      "${subdomain}-${replace(target, " ", "-")}" => merge(
        {
          subdomain = subdomain == "default" ? "" : subdomain
          target    = target
        },
        cfg
      )
    }
  ]...)
}

