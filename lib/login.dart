import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signup.dart';
import 'forgot.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final email = TextEditingController();
  final password = TextEditingController();

  bool isloading = false;

  // EMAIL LOGIN
  signIn() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar("Error", "All fields required");
      return;
    }

    setState(() => isloading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    }

    setState(() => isloading = false);
  }

  // GOOGLE LOGIN FUNCTION (IMPORTANT)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

      if (googleUser == null) return null; // user cancel

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance
          .signInWithCredential(credential);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: isloading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  SizedBox(height: 20),

                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.tealAccent.withOpacity(0.2),
                    child: Icon(Icons.balance, color: Colors.white),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "NyayaSeva",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 30),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [

                        Text(
                          "Welcome back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "आपका स्वागत है",
                          style: TextStyle(color: Colors.white70),
                        ),

                        SizedBox(height: 20),

                        // GOOGLE BUTTON
                        GestureDetector(
                          onTap: () async {
                            setState(() => isloading = true);

                            var user = await signInWithGoogle();

                            setState(() => isloading = false);

                            if (user != null) {
                              Get.snackbar("Success", "Google Login Success");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text("Sign in with Google"),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        Text("OR", style: TextStyle(color: Colors.white54)),

                        SizedBox(height: 15),

                        TextField(
                          controller: email,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        TextField(
                          controller: password,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text("Continue with Email"),
                          ),
                        ),

                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  Get.to(() => const Signup()),
                              child: Text(
                                "Create an account",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Get.to(() => const Forgot()),
                              child: Text(
                                "Forgot?",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}