class UserProfile {
  UserProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.rating,
    required this.vehiclesVerified,
    required this.licenseVerified,
    required this.completedJobs,
  });

  final String id;
  final String name;
  final UserRole role;
  final double rating;
  final bool vehiclesVerified;
  final bool licenseVerified;
  final int completedJobs;
}

enum UserRole { hirer, mover, admin }
