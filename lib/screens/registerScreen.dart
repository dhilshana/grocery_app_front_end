import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/main.dart';
import 'package:grocery_app/screens/homeScreen.dart';
import 'package:grocery_app/screens/loginScreen.dart';
import 'package:grocery_app/screens/rootScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/registerViewModel.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final registerView = context.watch<RegisterViewModel>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
              ),
              kSizedboxHeight,
              Text(
                'Name',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'Email',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'Password',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Text(
                'Number',
                style: TextStyle(fontSize: 18.sp),
              ),
              kHeightInTextField,
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor), // Border color when not focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kShadowColor,
                        width: 2), // Border color when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  fillColor: kWhiteColor,
                  filled: true,
                ),
              ),
              kSizedboxHeight,
              Container(
                decoration: BoxDecoration(
                    color: kGreenColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(
                            3, 3), // Positive values for bottom-right shadow
                        blurRadius: 5, // Adjust for smoothness
                        color: kShadowColor,
                        spreadRadius: 2, // Adjust for size of shadow
                      ),
                    ]),
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      registerView.registerUiHandler(name: nameController.text, email: emailController.text, password: passwordController.text, number: numberController.text, context: context);
                    },
                    child: registerView.isLoading?CupertinoActivityIndicator():Text(
                      'Register',
                      style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                    )),
              ),
              kSizedboxHeight,
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.black, // Default text color
                    fontSize: 16.sp, // Use ScreenUtil for responsive font size
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        color: kGreenColor, // Button color
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
