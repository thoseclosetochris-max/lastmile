import 'package:flutter/material.dart';

class PostJobScreen extends StatelessWidget {
  const PostJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post a Job')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Job details', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Item description')),
          const TextField(decoration: InputDecoration(labelText: 'Pickup location')),
          const TextField(decoration: InputDecoration(labelText: 'Dropoff location')),
          const TextField(decoration: InputDecoration(labelText: 'Size / dimensions')),
          const TextField(decoration: InputDecoration(labelText: 'Weight (kg)')),
          const TextField(decoration: InputDecoration(labelText: 'Time window')),
          const TextField(decoration: InputDecoration(labelText: 'Budget')),
          const TextField(decoration: InputDecoration(labelText: 'Handling notes')),
          const SizedBox(height: 16),
          const Text('Last-mile qualifiers',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Eco-friendly routing priority'),
            value: true,
            onChanged: (_) {},
          ),
          SwitchListTile(
            title: const Text('Bundle with other deliveries if possible'),
            value: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Submit job for matching'),
          ),
        ],
      ),
    );
  }
}
