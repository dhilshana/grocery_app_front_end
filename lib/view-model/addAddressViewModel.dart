import 'package:flutter/material.dart';
import 'package:grocery_app/services/apiServices.dart';

class AddAddressViewModel extends ChangeNotifier{
  bool isLoading = false;
  int? userId;
  ApiServices apiServices = ApiServices();

  Future<void> addAddressUiHandler({
    required BuildContext context,
    required String name,
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String country
    }) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      final result = await apiServices.addAddress(
        userId: (userId??0).toString(), 
        name: name, 
        phone: phone, 
        address1: address1, 
        address2: address2, 
        city: city, 
        state: state, 
        country: country);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
      Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}