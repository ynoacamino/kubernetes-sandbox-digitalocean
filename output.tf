output "node_info" {
  description = "Información de todos los nodos creados"
  value = {
    for key, node in digitalocean_droplet.nodes : key => {
      name   = node.name
      ip     = node.ipv4_address
      domain = "${cloudflare_dns_record.node_dns[key].name}.${data.cloudflare_zone.main.name}"
    }
  }
}
