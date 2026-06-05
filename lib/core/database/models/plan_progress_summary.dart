class PlanProgressSummary {
  final int progressId;
  final int planId;
  final String title;
  final String description;
  final int totalDays;
  final int currentDay;
  final String status;

  const PlanProgressSummary({
    required this.progressId,
    required this.planId,
    required this.title,
    required this.description,
    required this.totalDays,
    required this.currentDay,
    required this.status,
  });
}
