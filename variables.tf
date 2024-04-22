# DNS Zone Variables
# ----------------------------------------------------------------------------
variable "zone" {
  type        = string
  description = "DNS Zone"
}

variable "record" {
  # Keys are subdomain,`default` is ""
  type = map(
    # Keys are target
    map(
      object({
        type = string
        ttl  = optional(number, 3600)
  })))
  description = <<EOT
    Map of list of DNS Record entries, where keys of map is subdomain (use `@`
    as key for default domain) and record item in the lists have following
    attributes:

      * `type: The type of the record
      * `target`: The value of the record
      * `ttl`: (optional) The TTL of the record, it shall be >= to 60.

    Example:
    ```json
    {
      "record": [
        "@": [
          {
            "target": "dns.server.tld",
            "type": "NS",
            "ttl": 0,
          },
        ]
      ]
    }
    ```
  EOT

  default = {}
}

variable "redirection" {
  type = list(object({
    subdomain   = optional(string, "")
    type        = string
    ttl         = optional(number, 3600)
    target      = string
    description = optional(string)
    keywords    = optional(string)
    title       = optional(string)
  }))
  description = <<EOT
    List of DNS Redirection entries, of the form :"
      - type: The type of the redirection
          * `visible` -> Redirection by http code 302
          * `visiblePermanent` -> Redirection by http code 301
          * `invisible` -> Redirection by html frame
        target: The value of the record
        ttl: (optional) The TTL of the record, it shall be >= to 60.
        description: (optional) A description of this redirection
        keywords: (optional) Keywords to describe this redirection
        title: (optional) Title of this redirection
  EOT

  default = []
}
