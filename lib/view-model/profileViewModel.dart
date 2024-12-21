import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/userModel.dart';
import 'package:grocery_app/services/apiServices.dart';
import 'package:grocery_app/utils/constants.dart';

class ProfileViewModel extends ChangeNotifier{
   ApiServices apiServices = ApiServices();
  bool isLoading = false;
  int? userId;
  UserModel? user;
     TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

  Future<void> viewUserDataUiHandler(BuildContext context)async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      user = await apiServices.getUserData(userId: userId??0);
       nameController.text = user?.name ?? '';
      emailController.text = user?.email ?? '';
      phoneController.text = (user?.number??0).toString();
      notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading = false;
      notifyListeners();
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
                    viewUserDataUiHandler(context);
                  }, child:const Text('OK')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child:const Text('Cancel')),
                ],
              );
            },);
  }
}