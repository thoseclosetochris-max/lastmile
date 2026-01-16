import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart';
import 'integrations_screen.dart';
import 'jobs_screen.dart';
import 'post_job_screen.dart';
import 'profile_screen.dart';
import 'tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<Widget> _screens = const [
    JobsScreen(),
    PostJobScreen(),
    TrackingScreen(),
    IntegrationsScreen(),
    ProfileScreen(),
    AdminDashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Jobs'),
          NavigationDestination(icon: Icon(Icons.add_box), label: 'Post'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Track'),
          NavigationDestination(icon: Icon(Icons.link), label: 'Retail'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.shield), label: 'Admin'),
        ],
      ),
    );
  }
}
