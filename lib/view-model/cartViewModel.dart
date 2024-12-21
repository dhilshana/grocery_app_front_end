import 'package:flutter/material.dart';
import 'package:grocery_app/model/cartModel.dart';
import 'package:grocery_app/services/apiServices.dart';

class CartViewModel extends ChangeNotifier{
  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  int? userId;
  CartModel? cart;



  void cartScreenUiHandler(BuildContext context)async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();

      cart = await apiServices.getCart(userId: userId??0);
      notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    finally{
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCartUiHandler({required BuildContext context,required int cartId}) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      notifyListeners();
      await apiServices.deleteCart(cartId: cartId, userId: userId??0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted Successfully')));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> decrementCartUiHandler({required BuildContext context,required int cartId}) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      notifyListeners();
      final response = await apiServices.decrementCart(userId: userId??0, cartId: cartId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['Message'])));
      cartScreenUiHandler(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isLoading = false;
    }
  }

  Future<void> incrementCartUiHsndler({required BuildContext context,required int cartId}) async{
    try{ 
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      final response = await apiServices.incrementCart(cartId: cartId, userId: userId??0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['Message'])));
      cartScreenUiHandler(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrderUiHandler({required BuildContext context}) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      final data = await apiServices.addOrder(userId: userId??0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
      cartScreenUiHandler(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}