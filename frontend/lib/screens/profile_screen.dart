import 'package:flutter/material.dart';
import '../services/mock_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockDataService().users().first;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: Theme.of(context).textTheme.headlineSmall),
            Text('Role: ${user.role.name}'),
            Text('Rating: ${user.rating}'),
            const SizedBox(height: 16),
            const Text('Verification', style: TextStyle(fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(user.vehiclesVerified ? Icons.check_circle : Icons.error),
              title: const Text('Vehicle verification'),
              subtitle: Text(user.vehiclesVerified ? 'Verified' : 'Pending'),
            ),
            ListTile(
              leading: Icon(user.licenseVerified ? Icons.check_circle : Icons.error),
              title: const Text('License verification'),
              subtitle: Text(user.licenseVerified ? 'Verified' : 'Pending'),
            ),
            const SizedBox(height: 16),
            const Text('Insurance & compliance',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text(
              'Please confirm valid insurance and acknowledge GDPR-style privacy terms.',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Update profile'),
            ),
          ],
        ),
      ),
    );
  }
}
