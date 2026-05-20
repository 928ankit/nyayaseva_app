import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'login.dart';
import 'splash.dart';

class Wrapper extends StatefulWidget {

  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool showSplash = true;

  @override
  void initState() {

    super.initState();

    Timer(const Duration(seconds: 3), () {

      if (mounted) {

        setState(() {

          showSplash = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // SHOW CUSTOM SPLASH
    if (showSplash) {

      return const SplashScreen();
    }

    return StreamBuilder<User?>(

      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        if (snapshot.hasData) {

          return const Homepage();
        }

        return const Login();
      },
    );
  }
}