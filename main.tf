# ------------------------------------------------------------
# Root Module - Main Orchestration
# ------------------------------------------------------------
# Root Module - Main Orchestration
# ------------------------------------------------------------
# 이 파일은 전체 Terraform 실행의 중심 파일이다.
#
# 역할:
# 1. collector module 반복 생성
# 2. 각 collector 하위에 정의된 source 목록을 flatten 처리
# 3. flatten된 source 데이터를 기반으로 source module 반복 생성
#
# 핵심 개념:
# - collector는 var.collectors를 기준으로 for_each 생성
# - source는 collector 안에 중첩된 구조이므로 바로 for_each 하기 어렵다
# - 따라서 locals + flatten을 사용해 1차원 목록으로 변환한 후 생성한다
#
# 데이터 흐름:
# var.collectors
#   -> module.collectors
#   -> locals.sources (flatten)
#   -> module.sources
# ------------------------------------------------------------


# ------------------------------------------------------------
# 1) Collector Modules
# ------------------------------------------------------------
# 각 collector를 반복 생성한다.
#
# 결과 예:
# - module.collectors["collector1"]
# - module.collectors["collector2"]
#
# 각 module은 내부적으로 sumologic_collector 리소스를 생성한다.
# ------------------------------------------------------------

module "cloudtrail_collectors" {
  source = "./modules/collector"

  for_each = var.collectors

  name        = each.value.name
  description = each.value.description
}


# ------------------------------------------------------------
# 2) Flatten Source Definitions
# ------------------------------------------------------------
# collectors 변수 안에는 source가 collector별로 중첩되어 있다.
#
# 예:
# collectors = {
#   collector1 = {
#     sources = {
#       source1 = {...}
#       source2 = {...}
#     }
#   }
# }
#
# Terraform은 이런 중첩 구조를 바로 module for_each에 쓰기 불편하므로,
# 아래 locals.sources에서 1차원 list 형태로 펼친다.
#
# 생성되는 각 항목은 다음 정보를 포함한다:
# - key            : collector_key-source_key 조합의 고유 key
# - collector_key  : 어떤 collector에 속하는 source인지 식별
# - name           : source 이름
# - bucket_name    : CloudTrail S3 bucket 이름
# - path_expression: CloudTrail path expression
# - role_arn       : Sumo Logic이 사용할 AWS role ARN
# ------------------------------------------------------------

locals {
  sources = flatten([
    for c_key, c in var.collectors : [
      for s_key, s in c.sources : {
        key             = "${c_key}-${s_key}"
        collector_key   = c_key
        name            = s.name
        bucket_name     = s.bucket_name
        path_expression = s.path_expression
        role_arn        = s.role_arn
      }
    ]
  ])
}


# ------------------------------------------------------------
# 3) CloudTrail Source Modules
# ------------------------------------------------------------
# flatten된 source 목록을 기반으로 CloudTrail source를 생성한다.
#
# source는 collector에 종속되므로,
# collector_id를 module.collectors[collector_key].collector_id 로 참조한다.
#
# 결과 예:
# - module.sources["collector1-source1"]
# - module.sources["collector1-source2"]
# - module.sources["collector2-source1"]
#
# 주의:
# - 여기서 collector_id는 collector module output을 통해 전달받는다.
# - root output은 필요 없고, module output만 있으면 된다.
# ------------------------------------------------------------

module "sources" {
  source = "./modules/sumo_cloudtrail_source"

  for_each = {
    for s in local.sources :
    s.key => s
  }

  collector_id    = module.collectors[each.value.collector_key].collector_id
  name            = each.value.name
  bucket_name     = each.value.bucket_name
  path_expression = each.value.path_expression
  role_arn        = each.value.role_arn
}