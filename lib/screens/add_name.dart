import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:lovexl/screens/result.dart';

class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  final TextEditingController maleController = TextEditingController();
  final TextEditingController femaleController = TextEditingController();

  @override
  void dispose() {
    maleController.dispose();
    femaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Love Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.8,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF9B6CA),
              Color(0xFFFDE4CD),
            ],
          ),
        ),
        child: Stack(
          children: [
            //  Background Lottie Animation
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Lottie.asset(
                "assets/animations/heart_ani.json",
                height: 550,
                repeat: true,
              ),
            ),

            // Main content
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white30, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Enter Names",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildMinimalField(
                          controller: maleController,
                          label: "Male Name",
                          hint: "Enter his name",
                          icon: Icons.male_rounded,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 18),
                        _buildMinimalField(
                          controller: femaleController,
                          label: "Female Name",
                          hint: "Enter her name",
                          icon: Icons.female_rounded,
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              HapticFeedback.vibrate();
                              String maleName = maleController.text.trim();
                              String femaleName = femaleController.text.trim();

                              final nameRegExp = RegExp(r"^[a-zA-Z\s'-]+$");

                              if (maleName.isEmpty || femaleName.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter both names'),
                                  ),
                                );
                                return;
                              }

                              if (!nameRegExp.hasMatch(maleName) ||
                                  !nameRegExp.hasMatch(femaleName)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Are you kidding me? 🤨'),
                                  ),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                    maleName: maleName,
                                    femaleName: femaleName,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: const Color(0xFFE75480),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              'Calculate',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: color,
        ),
        prefixIcon: Icon(icon, size: 22, color: color),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: color.withValues(alpha:0.3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: color, width: 1.3),
        ),
        fillColor: Colors.white.withValues(alpha:0.9),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: color.withValues(alpha:0.6),
        ),
      ),
    );
  }
}

