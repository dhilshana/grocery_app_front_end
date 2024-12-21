import 'package:flutter/material.dart';
import 'package:grocery_app/screens/rootScreen.dart';
import 'package:grocery_app/screens/splashScreen.dart';
import 'package:grocery_app/services/apiServices.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices().getId(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError){
          return Center(child: Text('${snapshot.error} occured'),);
        }else if(snapshot.hasData && snapshot.data!= null){
          return  RootScreen();
        }else{
          return const SplashScreen();
        }
      },
      );
  }
}