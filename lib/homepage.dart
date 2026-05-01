import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;

  // LOGOUT FUNCTION (IMPORTANT)
  Future<void> signout() async {
    await GoogleSignIn().signOut(); // Google logout
    await FirebaseAuth.instance.signOut(); // Firebase logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [IconButton(onPressed: signout, icon: Icon(Icons.logout))],
      ),

      body: Center(
        child: Text(user?.email ?? "No Email", style: TextStyle(fontSize: 18)),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: signout,
        child: Icon(Icons.logout),
      ),
    );
  }
}
