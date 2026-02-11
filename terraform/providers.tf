terraform {
  required_version = ">= 1.11"
  required_providers {
    apko = {
      source = "chainguard-dev/apko"
      version = "1.0.8"
    }
    oci = {
      source = "chainguard-dev/oci"
      version = "0.0.27"
    }
  }
}
