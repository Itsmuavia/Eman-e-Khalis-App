import 'package:emane_khalis_app/Screens/Forgetpassword.dart';
import 'package:emane_khalis_app/Screens/Signuppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool ishow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/quran.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.4)),

          // Login Box
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.65),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              height: 480,
              width: 350,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "اسلام علیکم",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please login to your account",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.email_outlined),
                        labelText: "Email",
                        hintText: "Enter your email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Password Field
                    TextField(
                      obscureText: ishow,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              ishow = !ishow;
                            });
                          },
                          child: Icon(
                            ishow == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        labelText: "Password",
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Forget Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Forgetpassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Login Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 5,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Signup Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signuppage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    const Text(
                      "Login with",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),

                    // Social Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFF4285F4), // Blue
                                  Color(0xFF34A853), // Green
                                  Color(0xFFFBBC05), // Yellow
                                  Color(0xFFEA4335), // Red
                                ],
                              ).createShader(bounds);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.google,
                              size: 35,
                              color: Colors
                                  .white, // White icon for gradient effect
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
