import 'dart:async';
import 'package:flutter/material.dart';
import 'wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController rippleController;
  late AnimationController glowController;

  @override
  void initState() {
    super.initState();

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Redirect after 3 sec
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Wrapper()),
      );
    });
  }

  @override
  void dispose() {
    rippleController.dispose();
    glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🌊 Ripple + Glow Mic
            Stack(
              alignment: Alignment.center,
              children: [
                // Ripple animation
                AnimatedBuilder(
                  animation: rippleController,
                  builder: (context, child) {
                    return Container(
                      width: 150 + (rippleController.value * 120),
                      height: 150 + (rippleController.value * 120),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.cyan.withOpacity(
                          0.3 - rippleController.value * 0.3,
                        ),
                      ),
                    );
                  },
                ),

                // Glow mic
                AnimatedBuilder(
                  animation: glowController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(
                              0.7 * glowController.value,
                            ),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mic,
                        size: 60,
                        color: Colors.cyan,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Hindi text
            const Text(
              "न्यायसेवा",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // English text
            const Text(
              "NYAYASEVA",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.cyan,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "आपकी आवाज, आपका न्याय",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 40),

            // 🔥 Gradient Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mic, color: Colors.black),
                  SizedBox(width: 10),
                  Text(
                    "बोलना शुरू करें",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "🌐 Change Language / भाषा बदलें",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
