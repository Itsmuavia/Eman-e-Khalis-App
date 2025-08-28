import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Dummy Data
  final Map<String, String> userData = {
    'name': 'Eman-e-Khalis',
    'email': 'masjidtouheed@gmail.com',
    'contact': '+92 300 1234567',
    'creation-Time': '2025-08-28',
  };

  // Edit Dialog Box
  void _showProfileEditDialog(BuildContext context) {
    TextEditingController userController =
    TextEditingController(text: userData['name']);
    TextEditingController emailController =
    TextEditingController(text: userData['email']);
    TextEditingController contactController =
    TextEditingController(text: userData['contact']);
    TextEditingController creationTimeController =
    TextEditingController(text: userData['creation-Time']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.blue.shade900,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: userController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Username"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Contact"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: creationTimeController,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Last Updated At"),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text("Cancel"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Sirf dialog band karega
                Navigator.pop(context);
              },
              icon: const Icon(Icons.update, color: Colors.blue),
              label: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/splashlogo.png"),
              ),
              const SizedBox(height: 10),
              Text(
                userData['name']!,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              const Text(
                "Flutter Developer",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SourceSans3-BoldItalic",
                ),
              ),
              const SizedBox(
                width: 300,
                height: 20,
                child: Divider(color: Colors.grey),
              ),
              _buildInfoCard("Username: ${userData['name']}", Icons.person),
              _buildInfoCard("Email: ${userData['email']}", Icons.email),
              _buildInfoCard("Phone: ${userData['contact']}", Icons.phone),
              _buildInfoCard(
                  "Last Updated: ${userData['creation-Time']}", Icons.access_time),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text("Logout"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showProfileEditDialog(context);
                    },
                    icon: const Icon(Icons.update, color: Colors.blue),
                    label: const Text("Update Profile"),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(text),
      ),
    );
  }
}
