# ------------------------------------------------------------
# Module Outputs
# ------------------------------------------------------------
# 이 module에서 생성된 Sumo Logic Collector의 핵심 정보를 반환한다.
#
# - collector_id:
#   다른 module(예: source 생성)에서 해당 collector를 참조할 때 사용된다.
#
# 주의:
# - Terraform 내부 module 간 연결 시에는 이 output이 필수이다.
# - 단순 조회용 값(name 등)은 불필요하므로 최소한의 값만 반환한다.
# ------------------------------------------------------------

output "collector_id" {
  description = "Collector ID"
  value       = sumologic_collector.this.id
}
