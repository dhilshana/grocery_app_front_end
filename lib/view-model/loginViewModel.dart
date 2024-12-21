import 'package:flutter/material.dart';
import 'package:grocery_app/screens/forgotPasswordScreen.dart';
import 'package:grocery_app/screens/rootScreen.dart';
import 'package:grocery_app/services/authServices.dart';

class LoginViewModel extends ChangeNotifier{

    AuthServices authServices = AuthServices();

  bool isLoading = false;

  void loginUiHandler({required String email, required String password,required BuildContext context})async{
    try{
      isLoading = true;
      notifyListeners();
      Map<String,dynamic> data = await authServices.login(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => RootScreen()));
    }catch(e){
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    
    }

  }
  void forgotPasswordUiHandler({required BuildContext context}){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
  }
}