import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/singleCartWidget.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/cartViewModel.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      final cartView = Provider.of<CartViewModel>(context,listen: false);
      cartView.cartScreenUiHandler(context);
      
    });
  }
  @override
  Widget build(BuildContext context) {

    final cartView = context.watch<CartViewModel>();
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text('My Cart'),
        centerTitle: true,
        backgroundColor: kBgColor,
        toolbarHeight: 80.h,
      ),
      backgroundColor: kBgColor,
      body: Padding(padding: const EdgeInsets.all(15),
      child:cartView.cart == null?Center(child: CircularProgressIndicator(),):cartView.cart?.data == null?Center(
        child: Text('No Carts are added'),
      ) :Column(
        children: [
          GestureDetector(
            onTap: (){
              cartView.addOrderUiHandler(context: context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kGreenColor,
              ),
              child: Row(
                children: [
                  Text('Checkout all',style: TextStyle(
                    color: kWhiteColor
                  ),),
                  Spacer(),
                  Text('Subtotal : ₹${cartView.cart?.totalPrice}',
                  style: TextStyle(
                    color: kWhiteColor
                  ),)
                ],
              ),
            ),
          ),
          kSizedboxHeight,
          Expanded(
            child: ListView.builder(
              itemCount: cartView.cart?.data?.length,
              
              itemBuilder: (context, index) {
              return SingleCartWidget(
                image: cartView.cart?.data?[index].productImage??'image', 
              item: cartView.cart?.data?[index].productName??'item', 
              price: '₹${cartView.cart?.data?[index].productPrice}', 
              quantity: cartView.cart?.data?[index].quantity?.toDouble()??1.0,
              unit: cartView.cart?.data?[index].unit??'Kg',
              productId: int.parse(cartView.cart?.data?[index].productId??'0'),
              cartId: cartView.cart?.data?[index].id??0,);
             
            },),
          ),
        ],
      )),
    ));
  }
}