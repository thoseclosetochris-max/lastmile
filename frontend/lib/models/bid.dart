class Bid {
  Bid({
    required this.id,
    required this.jobId,
    required this.moverName,
    required this.price,
    required this.etaMinutes,
    required this.optimizationScore,
  });

  final String id;
  final String jobId;
  final String moverName;
  final double price;
  final int etaMinutes;
  final double optimizationScore;
}
