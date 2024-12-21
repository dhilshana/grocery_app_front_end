import 'package:flutter/material.dart';
import 'package:grocery_app/model/wishlistModel.dart';
import 'package:grocery_app/services/apiServices.dart';

class FavouriteViewModel extends ChangeNotifier{
  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  int? userId;
  List<WishlistModel> wishlist = [];
  String? message;



  void viewWishlistUiHandler({required BuildContext context}) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices. getId();
      wishlist = await apiServices.getWishlist(userId: userId??0);
      notifyListeners();
    }catch(e){
      message = e.toString();
      notifyListeners();      
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}