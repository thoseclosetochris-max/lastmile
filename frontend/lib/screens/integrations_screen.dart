import 'package:flutter/material.dart';

class IntegrationsScreen extends StatelessWidget {
  const IntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retailer Integrations')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Connect retailers to export shipments into the LastMile network.',
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('Walmart'),
              subtitle: const Text('Webhook configured · 24 shipments today'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Manage'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('Best Buy'),
              subtitle: const Text('Pending API key'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Connect'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Bulk upload', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload CSV manifest'),
          ),
        ],
      ),
    );
  }
}
