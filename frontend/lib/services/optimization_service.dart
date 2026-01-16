class OptimizationInputs {
  OptimizationInputs({
    required this.capacityUtilization,
    required this.routeEfficiency,
    required this.timeCompliance,
    required this.ecoFactor,
  });

  final double capacityUtilization;
  final double routeEfficiency;
  final double timeCompliance;
  final double ecoFactor;
}

class OptimizationService {
  double score(OptimizationInputs inputs) {
    return (inputs.capacityUtilization * 0.4) +
        (inputs.routeEfficiency * 0.3) +
        (inputs.timeCompliance * 0.2) +
        (inputs.ecoFactor * 0.1);
  }
}
