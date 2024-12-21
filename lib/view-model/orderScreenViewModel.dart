import 'package:flutter/material.dart';
import 'package:grocery_app/model/orderModel.dart';
import 'package:grocery_app/services/apiServices.dart';

class OrderScreenViewModel extends ChangeNotifier{
  bool isLoading = false;
  bool isDeleteLoading = false;
  ApiServices apiServices = ApiServices();
  int? userId;
  List<OrderModel> orders =[];

  String? message;
  Future<void> viewOrders({required BuildContext context}) async{
    try{
      isLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      orders = await apiServices.getOrders(userId: userId??0);
      notifyListeners();

    }catch(e){
      orders = [];
      message = e.toString();
      notifyListeners();
    }
    finally{
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteOrderUiHandler({required BuildContext context,required int orderId}) async{
    try{
      isDeleteLoading = true;
      notifyListeners();
      userId = await apiServices.getId();
      final result = await apiServices.deleteOrder(userId: userId??0, orderId: orderId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['Message'])));
      viewOrders(context: context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }finally{
      isDeleteLoading = false;
      notifyListeners();
    }
  }
}