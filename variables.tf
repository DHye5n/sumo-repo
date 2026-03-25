# ------------------------------------------------------------
# Root Variables Definition
# ------------------------------------------------------------
# Terraform root module에서 사용하는 입력 변수 정의
#
# - sumo_access_* : Sumo Logic 인증 정보 (.env 통해 주입)
# - collectors    : 생성할 collector 목록 (map 형태)
#
# collectors 구조:
# {
#   key = {
#     name        = string
#     description = string (optional)
#   }
# }
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
  type = map(object({
    name        = string
    description = optional(string)
  }))
}