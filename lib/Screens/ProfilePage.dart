import 'package:emane_khalis_app/Screens/Qiblacompass.dart';
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
    TextEditingController nameController = TextEditingController(
        text: userData['name']);
    TextEditingController emailController = TextEditingController(
        text: userData['email']);
    TextEditingController contactController = TextEditingController(
        text: userData['contact']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
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
              child: const Text(
                  "Cancel", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  userData['name'] = nameController.text;
                  userData['email'] = emailController.text;
                  userData['contact'] = contactController.text;
                });
                Navigator.pop(context);
              },
              child: const Text(
                  "Update", style: TextStyle(color: Colors.white)),
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
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          color: color ?? Colors.teal.shade50,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(2, 3)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal.shade800, size: 26),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade900),
            ),
            const Spacer(),
            const Icon(
                Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'More',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Pacifico",
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, 3))
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
                          style: const TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userData['email']!,
                          style: TextStyle(fontSize: 14, color: Colors.grey
                              .shade700),
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: "Logout",
                    child: IconButton(
                      icon: const Icon(
                          Icons.logout, color: Colors.red, size: 28),
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
              onTap: () => _showProfileEditDialog(context),
            ),
            _buildCardButton(
                icon: Icons.explore,
                title: "Qibla",
                color: Colors.green.shade100,
                onTap: () =>
                {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Qiblacompass()))
            }
            ),
            _buildCardButton(
              icon: Icons.checklist_rtl,
              title: "Ibadat Tracker",
              color: Colors.blue.shade100,
              onTap: () => Navigator.pushNamed(context, '/ibadat'),
            ),
            _buildCardButton(
              icon: Icons.fingerprint,
              title: "Tasbeeh Counter",
              color: Colors.grey.shade400,
              onTap: () => Navigator.pushNamed(context, '/tasbeeh'),
            ),
          ],
        ),
      ),
    );
  }
}
