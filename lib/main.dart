import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:nyayaseva_app/splash.dart';
import 'package:nyayaseva_app/theme/app_theme.dart';
import 'package:nyayaseva_app/wrapper.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'NyayaSeva',

      theme: AppTheme.lightTheme,

      home: const Wrapper(),
    );
  }
}