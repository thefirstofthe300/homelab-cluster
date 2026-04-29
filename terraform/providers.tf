terraform {
  required_version = ">= 1.11"
  required_providers {
    apko = {
      source = "chainguard-dev/apko"
      version = "1.2.5"
    }
    oci = {
      source = "chainguard-dev/oci"
      version = "0.1.2"
    }
  }
}
