import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/singleOrderWidget.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/orderScreenViewModel.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key}); 

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      final orderView = Provider.of<OrderScreenViewModel>(context,listen: false);
      orderView.viewOrders(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final orderView = context.watch<OrderScreenViewModel>();
    int l = orderView.orders.length;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title:const Text('My Orders'),
        centerTitle: true,
        backgroundColor: kBgColor,
        toolbarHeight: 80.h,
      ),
      backgroundColor: kBgColor,
      body: Padding(padding: const EdgeInsets.all(15),
      child:orderView.isLoading?
      Center(child: CircularProgressIndicator(color: kBlackColor,),):
      orderView.orders.isEmpty?Center(child: Text(orderView.message??'No Orders'),): 
      Column(
        children: [       
          Expanded(
            child: ListView.builder(
              itemCount: l,
              
              itemBuilder: (context, index) {
              return SingleOrderWidget(
                image: orderView.orders[index].productImage??'image', 
              item: orderView.orders[index].productName??'item', 
              price: '₹${orderView.orders[index].productPrice}', 
              quantity: orderView.orders[index].quantity?.toDouble()??1.0,
              unit: orderView.orders[index].unit??'Kg',
              productId: int.parse(orderView.orders[index].productId??'0'),
              orderId: orderView.orders[index].id??0,
              );
             
            },)
          ),
        ],
      )),
    ));
  }
}