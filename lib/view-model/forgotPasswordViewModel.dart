import 'package:flutter/material.dart';
import 'package:grocery_app/services/authServices.dart';

class ForgotPasswordViewModel extends ChangeNotifier{
  bool isVissible = false;
  bool isLoading = false;
  AuthServices authServices = AuthServices();
  int id = 0;

  void verifyEmailandPasswordUiHandler({required String email,required String number,required BuildContext context}) async{
    try{
      dynamic data = await authServices.verifyEmailandPassword(email: email, number: number);
      isVissible = true;
      isLoading = true;
      id = data['id'];
      notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading = false;
      notifyListeners();
    }    
  }

  void changePassword({required int id,required String newPassword,required BuildContext context}) async{
    try{
      isLoading = true;
      notifyListeners();
      Map<String,dynamic> data = await authServices.changePassword(id: id, newPassword: newPassword);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['Message'])));
      Navigator.pop(context);
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}