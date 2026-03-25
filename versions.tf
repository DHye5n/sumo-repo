terraform {
  required_version = ">= 1.5.0"

  required_providers {
    sumologic = {
      source  = "SumoLogic/sumologic"
      version = "~> 3.0"
    }
  }
}