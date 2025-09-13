import 'package:emane_khalis_app/Screens/Loginpage.dart';
import 'package:emane_khalis_app/Screens/Qiblacompass.dart';
import 'package:emane_khalis_app/Screens/Signuppage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, String> userData = {
    'name': 'Eman-e-Khalis',
    'email': 'masjidtouheed@gmail.com',
    'contact': '+92 300 1234567',
  };

  void _showProfileEditDialog(BuildContext context) {
    TextEditingController nameController =
    TextEditingController(text: userData['name']);
    TextEditingController emailController =
    TextEditingController(text: userData['email']);
    TextEditingController contactController =
    TextEditingController(text: userData['contact']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(
                    labelText: "Contact", border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child:
              const Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                setState(() {
                  userData['name'] = nameController.text;
                  userData['email'] = emailController.text;
                  userData['contact'] = contactController.text;
                });
                Navigator.pop(context);
              },
              child:
              const Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCardButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color1,
    Color? color2,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1 ?? Colors.blue.shade100, color2 ?? Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.shade200.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(2, 3)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  Icon(Icons.star, size: 35, color: Colors.amber.shade600),
                  const SizedBox(height: 8),
                  Text(
                    'More',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Pacifico",
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                      shadows: [
                        Shadow(
                            color: Colors.blue.shade200,
                            offset: const Offset(2, 2),
                            blurRadius: 3)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // PROFILE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue.shade100,
                      blurRadius: 8,
                      offset: const Offset(2, 3))
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/splashlogo.png"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['name']!,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userData['email']!,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: "Logout",
                    child: IconButton(
                      icon: const Icon(Icons.logout,
                          color: Colors.red, size: 28),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // BUTTONS LIST
            _buildCardButton(
              icon: Icons.edit,
              title: "Edit Profile",
              color1: Colors.indigo.shade300,
              onTap: () => _showProfileEditDialog(context),
            ),
            _buildCardButton(
              icon: Icons.explore,
              title: "Qibla",
              color1: Colors.teal.shade300,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QiblaCompass()));
              },
            ),
            _buildCardButton(
              icon: Icons.fingerprint,
              title: "Tasbeeh",
              color1: Colors.blueGrey.shade300,
              onTap: () => Navigator.pushNamed(context, '/tasbeeh'),
            ),

            const SizedBox(height: 25),

            // LOGIN & SIGNUP BUTTONS IN ROW
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: const Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signuppage()));
                    },
                    child: const Text("Signup",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
