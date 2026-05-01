import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nyayaseva_app/homepage.dart';
import 'package:nyayaseva_app/login.dart';
import 'package:nyayaseva_app/verifyemail.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // user logged in
          if (snapshot.hasData) {
            User user = snapshot.data!;

            // email verification check
            if (user.emailVerified ||
                user.providerData.any((p) => p.providerId == 'google.com')) {
              return Homepage();
            } else {
              return Verify();
            }
          }

          // not logged in
          return Login();
        },
      ),
    );
  }
}
