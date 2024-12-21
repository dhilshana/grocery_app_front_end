import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screens/registerScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/loginViewModel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginView = context.watch<LoginViewModel>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello !\nWelcome Back',
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
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
            kHeightInTextField,
            GestureDetector(
                onTap: () {
                  loginView.forgotPasswordUiHandler(context: context);
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 15.sp),
                )),
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
                    loginView.loginUiHandler(email: emailController.text, password: passwordController.text, context: context);
                  },
                  child: loginView.isLoading?CupertinoActivityIndicator(color: kWhiteColor,): Text(
                    'Login',
                    style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                  )),
            ),
            kSizedboxHeight,
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Colors.black, // Default text color
                  fontSize: 16.sp, // Use ScreenUtil for responsive font size
                ),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyle(
                      color: kGreenColor, // Button color
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
