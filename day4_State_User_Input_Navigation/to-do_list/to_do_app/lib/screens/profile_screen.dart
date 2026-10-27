import 'package:flutter/material.dart';

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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDark ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        backgroundColor: isDark? const Color.fromARGB(255, 55, 54, 54) : Colors.white10,
        appBar: AppBar(
          actions: [
            Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value; 
                });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("assets/new.jpg"),
                    backgroundColor: isDark ? Colors.white : Colors.black,
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
                   Text(
                    "Sher Ali Bajwa",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                    Text(
                    "flutter intern @ Tarsil Solutions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(
                    color: isDark ? Colors.white : Colors.black,
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
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required String text}) {
    return Card(
      elevation: 3,
      // color: isDark ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: isDark? Colors.teal.shade700 : Colors.amberAccent,),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.black : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
