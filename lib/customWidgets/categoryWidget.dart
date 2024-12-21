import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/categoryModel.dart';
import 'package:grocery_app/utils/constants.dart';

class CategoryWidget extends StatelessWidget {
  CategoryModel category;
  CategoryWidget({super.key,required this.category,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 40.r,
          backgroundColor: kWhiteColor,
          backgroundImage: NetworkImage(category.categoryImage??'category_image'), 
          
          ),
          kHeightInTextField,
          Text(category.categoryName??'category_name',style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}