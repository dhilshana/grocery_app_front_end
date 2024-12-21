import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/userDetailsWidget.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/accountScreenViewModel.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final accountView =
          Provider.of<AccountScreenViewModel>(context, listen: false);
      accountView.getUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountView = context.watch<AccountScreenViewModel>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
        backgroundColor: kBgColor,
        toolbarHeight: 80.h,
      ),
      backgroundColor: kBgColor,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            UserDetailsWidget(
                title: 'Name', value: accountView.user?.name ?? 'name'),
            Divider(),
            UserDetailsWidget(
                title: 'Email', value: accountView.user?.email ?? 'email'),
            Divider(),
            UserDetailsWidget(
                title: 'Phone Number',
                value: (accountView.user?.number ?? '0').toString()),
            Divider(),
            GestureDetector(
              onTap: () {
                accountView.logoutUiHandler(context);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                ),
              ),
            ),
            Divider(),
            kSizedboxHeight,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kGreenColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                  onPressed: () {
                    accountView.showDeleteDialogue(context);
                  },
                  child: Text(
                    'Delete Your Account',
                    style: TextStyle(color: kWhiteColor),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
