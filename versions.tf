# ------------------------------------------------------------
# Terraform / Provider Version Constraints
# ------------------------------------------------------------
# 이 파일은 Terraform 버전과 provider 버전을 고정한다.
#
# 목적:
# - 팀원 간 동일한 실행 환경 보장
# - Terraform / Provider 버전 차이로 인한 오류 방지
# - CI/CD 환경과 로컬 환경의 일관성 유지
#
# 주의:
# - child module에서도 같은 provider source를 인식할 수 있도록
#   module 쪽에도 required_providers를 선언하는 것이 안전하다.
# ------------------------------------------------------------

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    sumologic = {
      source  = "SumoLogic/sumologic"
      version = "~> 3.0"
    }
  }
}