terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    sops = {
      source = "carlpett/sops"
      version = "1.4.0"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
  
  encryption {
    key_provider "pbkdf2" "key_provider" {
      passphrase = var.passphrase
    }

    method "aes_gcm" "encryption_method" {
      keys = key_provider.pbkdf2.key_provider
    }

    state {
      method   = method.aes_gcm.encryption_method
      enforced = true
    }
  }

}


provider "digitalocean" {
  token = data.sops_file.secrets.data["digitalocean_token"]
}

provider "cloudflare" {
  api_token = data.sops_file.secrets.data["cloudflare_token"]
}

provider "sops" {}