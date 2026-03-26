# ------------------------------------------------------------
# Module Provider Requirements
# ------------------------------------------------------------
# 이 module이 사용하는 provider source를 명시한다.
#
# 목적:
# - Terraform이 provider를 hashicorp/sumologic 로 오인하지 않도록 방지
# - root module과 동일한 provider source를 사용하게 보장
# ------------------------------------------------------------

terraform {
  required_providers {
    sumologic = {
      source = "SumoLogic/sumologic"
    }
  }
}