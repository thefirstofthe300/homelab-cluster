terraform {
  required_version = ">= 1.11"
  required_providers {
    apko = {
      source = "chainguard-dev/apko"
      version = "1.2.29"
    }
    oci = {
      source = "chainguard-dev/oci"
      version = "0.2.4"
    }
  }
}
