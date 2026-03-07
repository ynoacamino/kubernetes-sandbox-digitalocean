data "digitalocean_ssh_key" "ynoacamino-pc" {
  name = "ynoacamino-pc"
}

data "digitalocean_ssh_key" "ynoacamino-lp" {
  name = "ynoacamino-lp"
}

data "cloudflare_zone" "main" {
  zone_id = data.sops_file.secrets.data["cloudflare_zone_id"]
}

locals {
  nodes_flat = flatten([
    for region, config in var.nodes : [
      for i in range(config.node_count) : {
        region = region
        size   = config.size
        index  = i + 1
        key    = "${region}-node-${i + 1}"
      }
    ]
  ])
}

resource "digitalocean_droplet" "nodes" {
  for_each = { for node in local.nodes_flat : node.key => node }

  image   = "ubuntu-24-04-x64"
  name    = each.value.key
  region  = each.value.region
  size    = each.value.size
  backups = false

  ssh_keys = [
    data.digitalocean_ssh_key.ynoacamino-pc.id,
    data.digitalocean_ssh_key.ynoacamino-lp.id
  ]
}

resource "cloudflare_dns_record" "node_dns" {
  for_each = digitalocean_droplet.nodes

  zone_id = data.sops_file.secrets.data["cloudflare_zone_id"]
  name = each.value.name
  type = "A"
  content = each.value.ipv4_address
  ttl = 1
  proxied = false
}