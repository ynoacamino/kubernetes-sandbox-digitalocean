variable "digitalocean_token" {
  type      = string
  sensitive = true
}

variable "nodes" {
  type = map(object({
    size       = string
    node_count = number
  }))
}
