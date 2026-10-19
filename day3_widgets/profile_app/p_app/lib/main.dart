import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Profile App",
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade700,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/new.jpg"),
                  backgroundColor: Colors.white,
                  // child: Text(
                  //   "SAB",
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.teal,
                  //   ),
                  // ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Sher Ali Bajwa",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "flutter intern @ Tarsil Solutions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 24),
                Divider(
                  color: Colors.white30,
                  thickness: 1.2,
                  indent: 40,
                  endIndent: 40,
                ),
                const SizedBox(height: 24),
                _buildContactCard(
                  icon: Icons.phone_android_rounded,
                  text: "03425796139",
                ),
                const SizedBox(height: 14),
                _buildContactCard(
                  icon: Icons.email_rounded,
                  text: "sheralib263@gmail.com",
                ),
                const SizedBox(height: 14),
                _buildContactCard(
                  icon: Icons.location_on_rounded,
                  text: "Chenab boys hostel",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildContactCard({required IconData icon, required String text}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal.shade700, size: 24),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

