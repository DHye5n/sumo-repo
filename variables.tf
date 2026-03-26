# ------------------------------------------------------------
# Root Variables Definition
# ------------------------------------------------------------
# Terraform root module에서 사용하는 입력 변수 정의
#
# 현재 구성:
# - sumo_access_id / sumo_access_key
#   : Sumo Logic provider 인증에 사용
#
# - collectors
#   : 생성할 collector 및 source 목록을 담는 핵심 변수
#
# collectors 구조 설명:
#
# collectors = {
#   collector1 = {
#     name = "collector-name"
#
#     sources = {
#       source1 = {
#         name            = "source-name"
#         bucket_name     = "bucket-name"
#         path_expression = "AWSLogs/*/CloudTrail/*"
#         role_arn        = "arn:aws:iam::..."
#       }
#     }
#   }
# }
#
# 주의:
# - collectors의 바깥 key(예: collector1)는 Terraform 리소스 식별자 역할
# - name은 Sumo Logic에 실제 표시되는 이름
# - key를 바꾸면 신규 리소스로 인식될 수 있음
# - name만 바꾸면 기존 리소스 수정으로 처리될 수 있음
# ------------------------------------------------------------

variable "sumo_access_id" {
  type      = string
  sensitive = true
}

variable "sumo_access_key" {
  type      = string
  sensitive = true
}

variable "collectors" {
  description = "Collectors and their CloudTrail sources"
  type = map(object({
    name = string

    sources = optional(map(object({
      name            = string
      bucket_name     = string
      path_expression = string
      role_arn        = string
    })), {})
  }))
}