# ------------------------------------------------------------
# Module Outputs
# ------------------------------------------------------------
# 생성된 collector의 핵심 식별값을 반환한다.
#
# collector_id:
# - 다른 module(예: source module)에서 collector 참조 시 사용
#
# 주의:
# - name 같은 표시용 값은 root tfvars에 이미 있으므로 output으로 굳이
#   다시 노출하지 않아도 된다.
# - 연결에 필요한 최소 값만 반환하는 것이 관리상 유리하다.
# ------------------------------------------------------------

output "collector_id" {
  description = "Collector ID"
  value       = sumologic_collector.collector.id
}
