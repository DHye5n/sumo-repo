# ------------------------------------------------------------
# Sumo Collector Module
# ------------------------------------------------------------
# Sumo Logic Hosted Collector 생성 module
#
# 입력:
# - name        : collector 이름
# - description : collector 설명
#
# 이 module은 단일 collector 생성 역할만 담당하며,
# 반복 생성은 root module에서 처리한다.
# ------------------------------------------------------------

resource "sumologic_collector" "this" {
  name        = var.name
  description = var.description
}