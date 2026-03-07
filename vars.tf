data "sops_file" "secrets" {
  source_file = "./vault/tf.yaml"
}

variable "passphrase" {
  type = string
  sensitive = true
}

variable "nodes" {
  type = map(object({
    size       = string
    node_count = number
  }))
}
