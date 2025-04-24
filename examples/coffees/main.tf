terraform {
  required_providers {
    hashicups = {
      # source = "local/edu/hashicups"
      source = "hashicorp.com/edu/hashicups"
      version = "0.1.0"
    }
  }
}

provider "hashicups" {
  host     = "http://localhost:19090"
  username = "education"
  password = "test123"
}


data "hashicups_coffees" "edu" {}

output "edu_coffees" {
  value = data.hashicups_coffees.edu
}
