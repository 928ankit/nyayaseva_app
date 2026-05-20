import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  bool isLogoutLoading = false;

  Future<void> signout() async {

    if (isLogoutLoading) return;

    setState(() {
      isLogoutLoading = true;
    });

    try {

      await googleSignIn.signOut();

      await FirebaseAuth.instance.signOut();

    } catch (e) {

      debugPrint("Logout Error: $e");

    } finally {

      if (mounted) {

        setState(() {
          isLogoutLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor: const Color(0xFF081A2E),

      appBar: AppBar(

        backgroundColor: const Color(0xFF123F4A),

        title: const Text(
          "NyayaSeva",
          style: TextStyle(color: Colors.white),
        ),

        actions: [

          isLogoutLoading

              ? const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          )

              : IconButton(

            onPressed: signout,

            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: Center(

        child: Text(

          user?.email ?? "No Email",

          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}