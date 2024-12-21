
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/forgotPasswordViewModel.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = context.watch<ForgotPasswordViewModel>();
    TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    return SafeArea(child: Scaffold(
      backgroundColor: kBgColor,
      body: Padding(padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              'Phone Number',
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
            
     
            Visibility(
              visible: !forgotPasswordProvider.isVissible,
              child: Column(
                children: [
                  kHeightInTextField,
                  ElevatedButton(
                      onPressed: () {
                        forgotPasswordProvider.verifyEmailandPasswordUiHandler(email: emailController.text, number: numberController.text, context: context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(kGreenColor),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                      ),
                      child:forgotPasswordProvider.isLoading?CupertinoActivityIndicator(color: kWhiteColor,): Text(
                        'Submit',
                        style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                      )),
                ],
              ),
            ),
                kSizedboxHeight,
                Visibility(
                  visible: forgotPasswordProvider.isVissible,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
     
            TextButton(
                onPressed: () {
                        int id = forgotPasswordProvider.id;
                  print('id = $id');
                  forgotPasswordProvider.changePassword(id: id, newPassword: passwordController.text, context: context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kGreenColor),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                ),
                child: forgotPasswordProvider.isLoading?CupertinoActivityIndicator(color: kWhiteColor,): Text(
                  'Submit',
                  style: TextStyle(color: kWhiteColor, fontSize: 18.sp),
                )),
                  ],
                ))
        ],
      ),),
    ));
  }
}