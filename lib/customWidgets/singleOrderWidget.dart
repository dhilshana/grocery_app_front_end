import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/orderScreenViewModel.dart';
import 'package:provider/provider.dart';

class SingleOrderWidget extends StatefulWidget {
   String item;
  String image;
  double quantity;
  String unit;
  String price;
  int productId;
  int orderId;
  SingleOrderWidget({super.key,
  required this.image,
  required this.item,
  required this.price,
  required this.productId,
  required this.quantity,
  required this.unit,
  required this.orderId});

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {

    final orderView = context.watch<OrderScreenViewModel>();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(offset: Offset(3, 3), color: kShadowColor, blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(widget.image,height: 100.h,),
            kWidthinFavouriteItem,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                kHeightInTextField,
                Text(
                  '${widget.quantity} ${widget.unit}',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                ),
                kHeightInTextField,
                Text(
                  '${widget.price}',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Spacer(),
            IconButton(onPressed: ()async {
              orderView.deleteOrderUiHandler(context: context, orderId: widget.orderId);
            }, 
            icon: Icon(Icons.delete_outlined))
          ],
        ),
      ),
    );
  }
}