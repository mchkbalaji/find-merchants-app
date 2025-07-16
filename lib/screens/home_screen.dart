import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _requestLocationPermission(BuildContext context) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is required.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Find Merchants\nNear You...',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            // Replace with your actual asset or Figma export
            Image.asset(
              'assets/merchant_illustration.png',
              height: 280,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => _requestLocationPermission(context),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Enable Location Access',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'We need your permission to find stores near you',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
