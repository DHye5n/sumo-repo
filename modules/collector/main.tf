# ------------------------------------------------------------
# Sumo Collector Module
# ------------------------------------------------------------
# 단일 Sumo Logic Hosted Collector를 생성하는 module
#
# 이 module의 책임:
# - collector 하나 생성
#
# 반복 생성 책임:
# - root module에서 for_each로 담당
#
# 즉, 이 module은 "단일 리소스 생성"만 담당하는 재사용 가능한 틀이다.
# ------------------------------------------------------------

resource "sumologic_collector" "collector" {
  name        = var.name
  description = var.description
}