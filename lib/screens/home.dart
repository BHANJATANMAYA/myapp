import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:lovexl/screens/add_name.dart';
import 'package:lovexl/screens/t_and_c.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color(0xFFB1E3F5),
              Color(0xFFF9B6CA),
              Color(0xFFFDE4CD),              
            ],
          ),
        ),
        child: Stack(
          children: [
            //  Lottie animation
            Positioned(
              top: 170,
              left: 0,
              right: 0,
              child: Lottie.asset(
                "assets/animations/try_ani.json",
                height: 200,
                repeat: true,
                reverse: false,
                animate: true,
              ),
            ),

            // Bottom 
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE75480),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(double.infinity, 55),
                          ),
                          onPressed: () {
                            HapticFeedback.vibrate();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddName()),
                            );
                          },
                          child: const Text(
                            "Let's get started",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text.rich(
                          TextSpan(
                            text: "By continuing you agree to our\n",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms of Use & Privacy Policy",
                                style: const TextStyle(
                                  color: Color(0xFFE75480),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
                                    );
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                   
                  ),
                  
                ),
                 const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
