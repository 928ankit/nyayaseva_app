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
  bool showPassword = false;
  bool wrongPassword = false;

  // EMAIL LOGIN
  signIn() async {
    if (email.text.isEmpty) {
      Get.snackbar("Error", "Enter email first");
      return;
    }

    if (!showPassword) {
      setState(() {
        showPassword = true;
      });
      return;
    }

    if (password.text.isEmpty) {
      Get.snackbar("Error", "Enter password");
      return;
    }

    setState(() => isloading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        wrongPassword = true;
      });
      Get.snackbar("Error", e.code);
    }

    setState(() => isloading = false);
  }

  // GOOGLE LOGIN
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF081A2E),
              Color(0xFF0B1F3A),
              Color(0xFF0F2F4F),
              Color(0xFF123F4A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: isloading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),

                        // Logo
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.tealAccent.withOpacity(0.2),
                          child: const Icon(Icons.gavel, color: Colors.white),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "NyayaSeva",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Welcome back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                "आपका स्वागत है",
                                style: TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Securely access your legal counsel and documentation",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // GOOGLE BUTTON
                              GestureDetector(
                                onTap: () async {
                                  setState(() => isloading = true);
                                  var user = await signInWithGoogle();
                                  setState(() => isloading = false);

                                  if (user != null) {
                                    Get.snackbar(
                                      "Success",
                                      "Google Login Success",
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/google.png",
                                        height: 22,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Sign in with Google",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // OR
                              Row(
                                children: const [
                                  Expanded(
                                    child: Divider(color: Colors.white30),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(color: Colors.white30),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // EMAIL
                              TextField(
                                controller: email,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Email Address",
                                  hintStyle: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              // PASSWORD
                              if (showPassword)
                                TextField(
                                  controller: password,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.05),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 20),

                              // CONTINUE
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: signIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.tealAccent,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text("Continue with Email"),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // FORGOT
                              if (wrongPassword)
                                TextButton(
                                  onPressed: () => Get.to(() => const Forgot()),
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),

                              const SizedBox(height: 10),

                              // SIGNUP
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(
                                      "New to NyayaSeva? ",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Create an account",
                                      style: TextStyle(
                                        color: Color(0xFF00E0FF),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
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
