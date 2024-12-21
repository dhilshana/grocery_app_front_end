import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/favouriteViewModel.dart';
import 'package:grocery_app/view-model/singleProductViewModel.dart';
import 'package:provider/provider.dart';

class FavouriteItemWidget extends StatelessWidget {
  String image;
  String item;
  String price;
  int productId;
  FavouriteItemWidget({super.key,required this.image,required this.item,required this.price,required this.productId});

  @override
  Widget build(BuildContext context) {

       


    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(3,3),
            color: kShadowColor,
            blurRadius: 5
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(image,height: 100.h,),
            kWidthinFavouriteItem,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item,style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500
                ),),
                kHeightInTextField,
                Text(price,style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400
                ),)
              ],
              
            ),
            Spacer(),
            IconButton(onPressed: ()async{
              await context.read<SingleProductViewModel>().wishlist(product_id: productId, context: context);
            context.read<FavouriteViewModel>().viewWishlistUiHandler(context: context);
            
            }, icon: Icon(Icons.favorite,color: kBlackColor,))
          ],
        ),
      ),
    );
  }
}