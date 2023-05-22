import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'log_in.dart';

class MainSplashScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        curve: Curves.bounceInOut,
        duration: 400,
        splashIconSize: 350,
        splash: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  'lib/Screens/LoginScreen/img5.jpg',
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const CircularProgressIndicator()
          ],
        ),
        nextScreen: Social_login_Screen(),
      ),
    );
  }
}
