import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/userModel.dart';
import 'package:grocery_app/screens/splashScreen.dart';
import 'package:grocery_app/services/apiServices.dart';
import 'package:grocery_app/utils/constants.dart';

class AccountScreenViewModel extends ChangeNotifier{
  bool isLoading = false;
  ApiServices apiServices = ApiServices();
  UserModel? user;
  int? userId;

  TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();


  Future<void> getUserData(BuildContext context)async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
       nameController.text = user?.name ?? '';
      emailController.text = user?.email ?? '';
      phoneController.text = (user?.number??0).toString();
      notifyListeners();
      user = await apiServices.getUserData(userId: userId??0);
      notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void showEditProfileDialogue(BuildContext context)async{

    userId = await apiServices.getId();
    showDialog(context: context, builder: (context) {
              return AlertDialog(
                backgroundColor: kBgColor,
                title: Text('Edit your Profile',style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500
                ),),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration:const InputDecoration(
                        hintText: 'Name'
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration:const InputDecoration(
                        hintText: 'Email'
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration:const InputDecoration(
                        hintText: 'Phone Number'
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: ()async{
                    final result = await apiServices.editProfile(
                      userId: userId, 
                      name: nameController.text, 
                      email: emailController.text, 
                      phoneNumber: phoneController.text);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
                    Navigator.pop(context);
                    getUserData(context);
                  }, child:const Text('OK')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child:const Text('Cancel')),
                ],
              );
            },);
  }

  void showDeleteDialogue(BuildContext context)async{
    userId = await apiServices.getId();
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: kBgColor,
        title: Text('Are You Sure?',style: TextStyle(
          fontSize: 18
        ),),
        actions: [
          TextButton(onPressed: ()async{
            try{
              final result = await apiServices.deleteSingleUser(userId: userId??0);
              await apiServices.deleteId();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
              
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text('Yes',style: TextStyle(
            color: kGreenColor
          ),)),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel',style: TextStyle(
            color: kGreenColor
          ),)),
        ],
      );
    },);
  }

  void logoutUiHandler(BuildContext context)async{
    try{
      await apiServices.deleteId();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You are logged out successfully')));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SplashScreen()), (route) => false,);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to logout. Please try again')));
    }
  }
}