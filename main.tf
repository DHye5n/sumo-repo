# ------------------------------------------------------------
# Root Module - Entry Point
# ------------------------------------------------------------
# 이 파일은 Terraform 실행의 시작점이며,
# 정의된 module들을 조합하여 실제 리소스를 생성한다.
#
# 현재 구성:
# - sumo_collector module을 반복(for_each)하여
#   여러 개의 Sumo Logic Hosted Collector를 생성
#
# collector 목록은 terraform.tfvars의 "collectors" 변수로 관리된다.
# ------------------------------------------------------------

module "cloudtrail_collectors" {
  source = "./modules/sumo_collector"

  for_each = var.collectors

  name        = each.value.name
  description = each.value.description
}