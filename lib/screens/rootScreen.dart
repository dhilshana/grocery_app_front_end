import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cartScreen.dart';
import 'package:grocery_app/screens/favouriteScreen.dart';
import 'package:grocery_app/screens/homeScreen.dart';
import 'package:grocery_app/screens/profileScreen.dart';
import 'package:grocery_app/utils/constants.dart';

class RootScreen extends StatefulWidget {
    int? index;

  RootScreen({super.key,this.index=0});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  List<Widget> pages =const [
    UserHomeScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded),label: "Favourites",),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded),label: "Cart",),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: "Profile",)
        ] ,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kBlackColor,
        unselectedItemColor: kWhiteColor,
        backgroundColor: kGreenColor,
        currentIndex: selectedIndex,
        ),
        body: pages[selectedIndex],
    );
  }
}