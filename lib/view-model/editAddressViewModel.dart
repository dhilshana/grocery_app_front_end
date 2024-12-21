import 'package:flutter/material.dart';
import 'package:grocery_app/services/apiServices.dart';

class EditAddressViewModel extends ChangeNotifier{
  

  bool isLoading = false;
  int? userId;
  ApiServices apiServices = ApiServices();
  Future<void> editAddressUiHandler({
    required int id, 
    required BuildContext context,
    required String name,
required String phone,
required String address1,
required String address2,
required String city,
required String state,
required String country})async{
    try{
      isLoading = false;
      notifyListeners();
      userId =await apiServices.getId();
      final result =await apiServices.updateAddress(userId: userId.toString(), addressId: id, name: name, phone: phone, address1: address1, address2: address2, city: city, state: state, country: country);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['Message'])));
      Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{

      isLoading = false;
      notifyListeners();
    }
  }
 
}