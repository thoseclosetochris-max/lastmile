import 'package:flutter/material.dart';
import '../widgets/info_card.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Tracking')),
      body: ListView(
        children: const [
          InfoCard(
            title: 'Jordan Lee • Ford Transit',
            subtitle: 'En route to pickup · ETA 12 min',
            trailing: Icon(Icons.directions_car),
          ),
          InfoCard(
            title: 'Route optimization',
            subtitle: 'Bundled 2 deliveries · 20% fuel savings',
            trailing: Icon(Icons.eco),
          ),
          InfoCard(
            title: 'Notifications',
            subtitle: 'Push alerts enabled for status updates',
            trailing: Icon(Icons.notifications_active),
          ),
        ],
      ),
    );
  }
}
