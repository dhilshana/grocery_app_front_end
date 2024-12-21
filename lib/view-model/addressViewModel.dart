import 'package:flutter/material.dart';
import 'package:grocery_app/screens/addAddressScreen.dart';
import 'package:grocery_app/model/addressModel.dart';
import 'package:grocery_app/services/apiServices.dart';

class AddressViewModel extends ChangeNotifier{
  bool isLoading = false;
  ApiServices apiServices = ApiServices();
  int? userId;
  List<AddressModel> address = [];
  bool isButtonLoading = false;
  bool isDelete = false;
  bool isEdit = false;

  Future<void> viewAddressUiHandler(BuildContext context) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      address = await apiServices.getAddress(userId: userId??0);
      notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future<void> addAddressButtonUiHandler(BuildContext context)async{
    try{
      isButtonLoading = true;
      notifyListeners();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressScreen())).then((onValue){
        viewAddressUiHandler(context);
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isButtonLoading=false;
      notifyListeners();
    }
  }

  Future<void> deleteSingleAddress({required int addressId,required BuildContext context})async{
    try{
      isDelete = true;
      notifyListeners();
      userId = await apiServices.getId();
      final result = await apiServices.deleteSingleAddress(userId: userId??0, addressId: addressId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['Message'])));
      viewAddressUiHandler(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isDelete = false;
      notifyListeners();
    }
  }

  Future<void> deleteAddress(BuildContext context)async{
    try{
      isDelete = true;
      notifyListeners();
      userId = await apiServices.getId();
      final result = await apiServices.deleteAddress(userId: userId??0);
      viewAddressUiHandler(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['Message'])));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isDelete = false;
      notifyListeners();
    }
  }


}