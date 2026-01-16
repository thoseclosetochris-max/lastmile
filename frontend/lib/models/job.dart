class Job {
  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.pickup,
    required this.dropoff,
    required this.size,
    required this.weightKg,
    required this.timeWindow,
    required this.budget,
    required this.handling,
    required this.status,
    required this.ecoPriority,
    required this.optimizationScore,
  });

  final String id;
  final String title;
  final String description;
  final Location pickup;
  final Location dropoff;
  final String size;
  final double weightKg;
  final String timeWindow;
  final double budget;
  final String handling;
  final JobStatus status;
  final bool ecoPriority;
  final double optimizationScore;
}

class Location {
  Location({
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  final String label;
  final double latitude;
  final double longitude;
}

enum JobStatus { open, matched, inTransit, delivered }
