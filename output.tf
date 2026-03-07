output "node_ips" {
  description = "IPs de todos los nodos creados"
  value = {
    for key, node in digitalocean_droplet.nodes : key => node.ipv4_address
  }
}
