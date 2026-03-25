# ------------------------------------------------------------
# Provider Configuration
# ------------------------------------------------------------
# Sumo Logic provider 설정
#
# - access_id / access_key는 코드에 직접 작성하지 않고
#   .env 파일을 통해 환경변수(TF_VAR_*)로 주입한다.
#
# 실행 전 반드시:
#   source .env
# ------------------------------------------------------------

provider "sumologic" {
  access_id  = var.sumo_access_id
  access_key = var.sumo_access_key
}