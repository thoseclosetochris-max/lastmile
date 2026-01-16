import '../models/bid.dart';
import '../models/job.dart';
import '../models/user_profile.dart';
import 'optimization_service.dart';

class MockDataService {
  MockDataService() : _optimization = OptimizationService();

  final OptimizationService _optimization;

  List<UserProfile> users() {
    return [
      UserProfile(
        id: 'u1',
        name: 'Avery Quinn',
        role: UserRole.hirer,
        rating: 4.8,
        vehiclesVerified: false,
        licenseVerified: true,
        completedJobs: 12,
      ),
      UserProfile(
        id: 'u2',
        name: 'Jordan Lee',
        role: UserRole.mover,
        rating: 4.9,
        vehiclesVerified: true,
        licenseVerified: true,
        completedJobs: 58,
      ),
      UserProfile(
        id: 'admin',
        name: 'Admin Console',
        role: UserRole.admin,
        rating: 5.0,
        vehiclesVerified: true,
        licenseVerified: true,
        completedJobs: 0,
      ),
    ];
  }

  List<Job> jobs() {
    return [
      Job(
        id: 'j1',
        title: 'Small apartment move',
        description: 'Boxes and a desk from Midtown to Greenpoint.',
        pickup: Location(label: 'Midtown NYC', latitude: 40.754, longitude: -73.984),
        dropoff:
            Location(label: 'Greenpoint NYC', latitude: 40.724, longitude: -73.95),
        size: 'Medium',
        weightKg: 120,
        timeWindow: 'Today, 2-4 PM',
        budget: 140,
        handling: 'Fragile desk',
        status: JobStatus.open,
        ecoPriority: true,
        optimizationScore: _optimization.score(
          OptimizationInputs(
            capacityUtilization: 0.82,
            routeEfficiency: 0.77,
            timeCompliance: 0.9,
            ecoFactor: 0.95,
          ),
        ),
      ),
      Job(
        id: 'j2',
        title: 'Retail shipment: electronics',
        description: 'Two laptop pallets - dock pickup.',
        pickup: Location(label: 'Queens DC', latitude: 40.728, longitude: -73.794),
        dropoff: Location(label: 'Brooklyn Hub', latitude: 40.678, longitude: -73.944),
        size: 'Large',
        weightKg: 420,
        timeWindow: 'Tomorrow, 9-11 AM',
        budget: 220,
        handling: 'Perishable? No. Needs lift gate.',
        status: JobStatus.matched,
        ecoPriority: false,
        optimizationScore: _optimization.score(
          OptimizationInputs(
            capacityUtilization: 0.9,
            routeEfficiency: 0.88,
            timeCompliance: 0.82,
            ecoFactor: 0.6,
          ),
        ),
      ),
      Job(
        id: 'j3',
        title: 'Furniture delivery bundle',
        description: '3 chairs + coffee table, bundle-ready.',
        pickup: Location(label: 'LIC Warehouse', latitude: 40.744, longitude: -73.948),
        dropoff: Location(label: 'Williamsburg', latitude: 40.708, longitude: -73.957),
        size: 'Small',
        weightKg: 60,
        timeWindow: 'Today, 6-9 PM',
        budget: 90,
        handling: 'Fragile wrapping',
        status: JobStatus.inTransit,
        ecoPriority: true,
        optimizationScore: _optimization.score(
          OptimizationInputs(
            capacityUtilization: 0.7,
            routeEfficiency: 0.8,
            timeCompliance: 0.85,
            ecoFactor: 0.9,
          ),
        ),
      ),
    ];
  }

  List<Bid> bidsForJob(String jobId) {
    return [
      Bid(
        id: 'b1',
        jobId: jobId,
        moverName: 'Jordan Lee',
        price: 128,
        etaMinutes: 45,
        optimizationScore: 0.86,
      ),
      Bid(
        id: 'b2',
        jobId: jobId,
        moverName: 'Skylar Rivers',
        price: 120,
        etaMinutes: 55,
        optimizationScore: 0.82,
      ),
    ];
  }
}
