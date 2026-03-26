# ------------------------------------------------------------
# Module Variables
# ------------------------------------------------------------
# collector 생성에 필요한 입력 변수 정의
# ------------------------------------------------------------

variable "name" {
  description = "Hosted collector name"
  type        = string
}

variable "description" {
  description = "Hosted collector description"
  type        = string
}