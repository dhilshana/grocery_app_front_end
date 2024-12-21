import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/screens/loginScreen.dart';
import 'package:grocery_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        (){
        if (mounted) { // Check if the widget is still mounted
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
        }
        );
  }

  @override


  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashscreen.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children:[ Positioned(
            bottom: 50,
            left: 135,
            
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              }, 
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kGreenColor),
                foregroundColor: WidgetStatePropertyAll(kWhiteColor),
               elevation: WidgetStatePropertyAll(10),
               shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))) 
              ),
              child: Text('Get Started')
              )
          ),
          ]
        ),
      ),
    ));
  }
}