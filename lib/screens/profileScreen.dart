import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/dpWidget.dart';
import 'package:grocery_app/customWidgets/profileMenuWiddget.dart';
import 'package:grocery_app/screens/addressScreen.dart';
import 'package:grocery_app/screens/myAccountScreen.dart';
import 'package:grocery_app/screens/odersScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/profileViewModel.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      final profileView = Provider.of<ProfileViewModel>(context,listen: false);
      profileView.viewUserDataUiHandler(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final profileView = context.watch<ProfileViewModel>();
    

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text('My Profile'),
        centerTitle: true,
        backgroundColor: kBgColor,
        toolbarHeight: 70.h,
      ),
      backgroundColor: kBgColor,
      body: Padding(padding:const  EdgeInsets.all(15),
      child:profileView.user?.id==null?Center(child: CircularProgressIndicator(color: kBlackColor,),): Column(
        children: [
          DpWidget(
            name: profileView.user?.name??'Provide Your Name',
            email: profileView.user?.email??'Provide Your Email',
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OrdersScreen()));
                  },
                  child: ProfileMenuWidget(title: 'My Orders',icon: Icon(Icons.shopping_bag_outlined),)),
                const Divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAccountScreen()));
                  },
                  child: ProfileMenuWidget(title: 'My Account',icon: Icon(Icons.account_box_outlined),)),
                const Divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));
                  },
                  child: ProfileMenuWidget(title: 'Delivery Address',icon: Icon(Icons.location_on_outlined),)),
                const Divider(),
                ProfileMenuWidget(title: 'Payment Method',icon: Icon(Icons.payment_outlined),),
              ],
            ),
          )
        ],
      ),
      )
    ));
  }
}