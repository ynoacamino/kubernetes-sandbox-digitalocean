provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "node-1" {
  image   = "ubuntu-24-04-x64"
  name    = "nyc3-node-1"
  region  = "nyc3"
  size    = "s-1vcpu-1gb"
  backups = false
}
