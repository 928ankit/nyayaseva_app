import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'wrapper.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    sendverifylink();
    super.initState();
  }

  // Send Verification Link
  sendverifylink() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification().then(
      (value) => {
        Get.snackbar(
          'Link sent',
          'A link has been send to your email',
          margin: EdgeInsets.all(30),
          snackPosition: SnackPosition.BOTTOM,
        ),
      },
    );
  }

  // Reload Page
  reload() async {
    await FirebaseAuth.instance.currentUser!.reload().then(
      (value) => Get.offAll(Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verification")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Text(
            'Open your mail and click on the link provided to verify email & reload this page.',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => reload(),
        child: Icon(Icons.restart_alt_rounded),
      ),
    );
  }
}
