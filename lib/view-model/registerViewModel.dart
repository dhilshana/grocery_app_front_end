import 'package:flutter/material.dart';
import 'package:grocery_app/screens/rootScreen.dart';
import 'package:grocery_app/services/authServices.dart';

class RegisterViewModel extends ChangeNotifier{

  AuthServices authServices = AuthServices();
  bool isLoading = false;


  void registerUiHandler({required String name,required String email,required String password,required String number,required BuildContext context}) async 
   {
     try {
      isLoading = true;
      notifyListeners();
      Map<String, dynamic> data = await authServices.register(
          name: name,
          email: email,
          password: password,
          number: number);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
          Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => RootScreen()));
     
    } catch (e) {
      print(e);
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
