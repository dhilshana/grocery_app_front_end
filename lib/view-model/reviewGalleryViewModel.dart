import 'package:flutter/material.dart';
import 'package:grocery_app/services/apiServices.dart';

class ReviewGalleryViewModel extends ChangeNotifier{
  bool isLoading = false;
  ApiServices apiServices = ApiServices();
  List<dynamic> images =[];
  void reviewImagesUiHandler(BuildContext context,{required int product_id})async{
    try{
      images = [];
      notifyListeners();
      isLoading = true;
      notifyListeners();
      images = await apiServices.getReviewImages(productId: product_id);
      notifyListeners();
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    finally{
      isLoading = false;
      notifyListeners();
    }
  }
}