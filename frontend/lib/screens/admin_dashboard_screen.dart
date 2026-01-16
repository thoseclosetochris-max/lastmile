import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Active disputes'),
              subtitle: const Text('2 open cases'),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Formula tuning'),
              subtitle: const Text('Capacity 0.4 · Route 0.3 · Time 0.2 · Eco 0.1'),
              trailing: IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Marketplace health'),
              subtitle: const Text('Avg fuel savings: 18% · Bundling rate: 32%'),
              trailing: IconButton(
                icon: const Icon(Icons.analytics),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
