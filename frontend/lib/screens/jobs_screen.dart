import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/mock_data.dart';
import '../widgets/info_card.dart';
import 'job_detail_screen.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = MockDataService().jobs();

    return Scaffold(
      appBar: AppBar(title: const Text('Available Jobs')),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return InfoCard(
            title: job.title,
            subtitle:
                '${job.pickup.label} → ${job.dropoff.label} · ${job.timeWindow}',
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${job.budget.toStringAsFixed(0)}'),
                Text('Score ${(job.optimizationScore * 100).toStringAsFixed(0)}%'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JobDetailScreen(job: job),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
