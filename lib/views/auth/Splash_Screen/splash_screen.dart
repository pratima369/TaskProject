import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import '../loginScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 2000),
       nextScreen: LoginPage(),
       backgroundColor: Colors.white,
      splashScreenBody: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/splash.jpeg'),fit: BoxFit.fill
          )
        ),

      ),
    );
  }
}
