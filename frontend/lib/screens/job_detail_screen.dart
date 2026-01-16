import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/mock_data.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    final bids = MockDataService().bidsForJob(job.id);

    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(job.description, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          _detailRow('Pickup', job.pickup.label),
          _detailRow('Dropoff', job.dropoff.label),
          _detailRow('Size', job.size),
          _detailRow('Weight', '${job.weightKg} kg'),
          _detailRow('Handling', job.handling),
          _detailRow('Time window', job.timeWindow),
          _detailRow('Budget', '\$${job.budget.toStringAsFixed(0)}'),
          _detailRow(
            'Optimization score',
            '${(job.optimizationScore * 100).toStringAsFixed(0)}% utilization',
          ),
          const SizedBox(height: 16),
          Text('Bids', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final bid in bids)
            Card(
              child: ListTile(
                title: Text(bid.moverName),
                subtitle: Text('ETA ${bid.etaMinutes} min'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$${bid.price.toStringAsFixed(0)}'),
                    Text('Score ${(bid.optimizationScore * 100).toStringAsFixed(0)}%'),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Accept bid & start escrow'),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(child: Text(value, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
