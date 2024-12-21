
import 'package:flutter/material.dart';
import 'package:grocery_app/model/productModel.dart';
import 'package:grocery_app/services/apiServices.dart';

class SingleProductViewModel extends ChangeNotifier{
  ApiServices apiServices = ApiServices();
  ProductModel? singleProduct; 
  double? price;
  double? quantity;
  int? userId;
   Map<int, bool> wishlistStatusMap = {};
  bool isLoading = false;
  bool addToCartLoading = false;
  bool viewReviewLoading = false;



  void viewSingleProductUiHandler({required BuildContext context, required int id})async{
    try{
  
      singleProduct = await apiServices.getSingleProduct(id: id);
      price = double.parse(singleProduct?.price??'0.0');
      notifyListeners();
      quantity = double.parse(singleProduct?.quantity??'1');
      notifyListeners();
      
    }catch(e){
    
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  void increment({required double fixedprice,required double fixedquatity,required BuildContext context}){
    try{
      price = fixedprice+price!;
      notifyListeners();
      quantity = fixedquatity+quantity!;
      notifyListeners();
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

void decrement({required double fixedprice,required double fixedquatity,required BuildContext context}){
    try{
      if(quantity!>0){
      price = price!-fixedprice;
      notifyListeners();
      quantity = quantity!-fixedquatity;
      notifyListeners();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> wishlist({required int product_id,required BuildContext context})async{
    
    try{
    
     userId = await apiServices. getId();
      final data = await apiServices.wishlist(product_id: product_id, user_id: userId??0);
      await getWishlistStatus(productId: product_id, context: context);
     
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> getWishlistStatus({required int productId,required BuildContext context})async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices. getId();
      final data = await apiServices.checkWishlistStatus(userId: userId??0, productId: productId);
      wishlistStatusMap[productId] = data['status'];
      notifyListeners();

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart({required int productId,required BuildContext context})async{
    try{
      addToCartLoading = true;
      notifyListeners();
     userId = await apiServices. getId();
      final data = await apiServices.addToCart(productId: productId, userId: userId??0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      addToCartLoading = false;
      notifyListeners();
    }
  }

  void addReviewUiHandler(BuildContext context,{required int productId, required String description, required int rating})async{
    try{
      viewReviewLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      final result = await apiServices.addReview(productId: productId, userId: userId??0, description: description, rating: rating);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      viewReviewLoading = false;
      notifyListeners();
    }
  }

}