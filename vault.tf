
data "vault_generic_secret" "state" {
  path = "secret/MySecret"
}

data "terraform_remote_state" "secretforaws" {
  backend = "s3"
  config {
    bucket = "secretforaws"
    access_key           = "${data.vault_generic_secret.state.data["access_key"]}"
    secret_key           = "${data.vault_generic_secret.state.data["secret_key"]}"
    key    = "secretforaws/terraform.tfstate"
    region = "us-east-1"
  }
}