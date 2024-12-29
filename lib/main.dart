import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/services/authCheck.dart';
import 'package:grocery_app/view-model/accountScreenViewModel.dart';
import 'package:grocery_app/view-model/addAddressViewModel.dart';
import 'package:grocery_app/view-model/addReviewViewModel.dart';
import 'package:grocery_app/view-model/addressViewModel.dart';
import 'package:grocery_app/view-model/cartViewModel.dart';
import 'package:grocery_app/view-model/categoryScreenViewModel.dart';
import 'package:grocery_app/view-model/editAddressViewModel.dart';
import 'package:grocery_app/view-model/favouriteViewModel.dart';
import 'package:grocery_app/view-model/forgotPasswordViewModel.dart';
import 'package:grocery_app/view-model/loginViewModel.dart';
import 'package:grocery_app/view-model/orderScreenViewModel.dart';
import 'package:grocery_app/view-model/profileViewModel.dart';
import 'package:grocery_app/view-model/registerViewModel.dart';
import 'package:grocery_app/view-model/reviewGalleryViewModel.dart';
import 'package:grocery_app/view-model/singleProductViewModel.dart';
import 'package:grocery_app/view-model/userHomeViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>Userhomeviewmodel()),
      ChangeNotifierProvider(create: (context)=> RegisterViewModel()),
      ChangeNotifierProvider(create: (context)=>LoginViewModel()),
      ChangeNotifierProvider(create: (context)=>ForgotPasswordViewModel()),
      ChangeNotifierProvider(create: (context)=>SingleProductViewModel()),
      ChangeNotifierProvider(create: (context)=>FavouriteViewModel()),
      ChangeNotifierProvider(create: (context)=> CartViewModel()),
      ChangeNotifierProvider(create: (context)=>ProfileViewModel()),
      ChangeNotifierProvider(create: (context)=> OrderScreenViewModel()),
      ChangeNotifierProvider(create: (context)=>AccountScreenViewModel()),
      ChangeNotifierProvider(create: (context)=>AddressViewModel()),
      ChangeNotifierProvider(create: (context)=>AddAddressViewModel()),
      ChangeNotifierProvider(create: (context)=>EditAddressViewModel()),
      ChangeNotifierProvider(create: (context)=>CategoryScreenViewModel()),
      ChangeNotifierProvider(create: (context)=>AddReviewViewModel()),
      ChangeNotifierProvider(create: (context)=>ReviewGalleryViewModel()),
    ],
    child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 806),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:const Scaffold(
          body: AuthCheck()
        ),
        theme: ThemeData(
      
          fontFamily: 'Geist',
         
        ),
      ),
    );
  }
}
