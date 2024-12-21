import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';

class ProductWidget extends StatelessWidget {
  String title;
  String image;
  String price;
  ProductWidget({super.key,required this.image,required this.title,required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,

        color: kWhiteColor,
        shadowColor: kShadowColor,
        elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Image.network(image,
                height: 120.h,
                fit:BoxFit.cover,
                )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(title,
            maxLines: 1,
            style: TextStyle(
              color: kBlackColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text('₹$price',style: TextStyle(
              color: kBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),),
          )
        ],
      ),
    );
  }
}