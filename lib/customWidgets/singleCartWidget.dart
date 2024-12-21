
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/cartViewModel.dart';
import 'package:grocery_app/view-model/singleProductViewModel.dart';
import 'package:provider/provider.dart';

class SingleCartWidget extends StatefulWidget {
  String item;
  String image;
  double quantity;
  String unit;
  String price;
  int productId;
  int cartId;
  SingleCartWidget(
      {super.key,
      required this.image,
      required this.item,
      required this.price,
      required this.quantity,required this.unit,
      required this.productId,
      required this.cartId,
      });

  @override
  State<SingleCartWidget> createState() => _SingleCartWidgetState();
}

class _SingleCartWidgetState extends State<SingleCartWidget> {
@override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final singleProductView =
          Provider.of<SingleProductViewModel>(context, listen: false);
      singleProductView.getWishlistStatus(
        productId: widget.productId,
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final singleProductView= context.watch<SingleProductViewModel>();
    final isFavorite =
        singleProductView.wishlistStatusMap[widget.productId] ?? false;
        final cartView = context.watch<CartViewModel>();


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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal:10,vertical: 5),
                  decoration:const BoxDecoration(
                      color: kWhiteColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 3),
                            color: kShadowColor,
                            blurRadius: 5)
                      ]),
                  child: Row(
              
                    children: [
                    
                         GestureDetector(
                          onTap: (){
                            cartView.decrementCartUiHandler(context: context, cartId: widget.cartId);
                          },
                          child:cartView.isLoading?CircularProgressIndicator(color: kBlackColor,): Icon(Icons.remove,size: 15,)),
                          kWidthinFavouriteItem,

                       
                      Text('${widget.quantity}',style:const TextStyle(
                        fontWeight: FontWeight.w600
                      ),),
                      kWidthinFavouriteItem,
                       GestureDetector(
                        onTap: (){
                          cartView.incrementCartUiHsndler(context: context, cartId: widget.cartId);
                        },
                        child:cartView.isLoading?CircularProgressIndicator(color: kBlackColor,): Icon(Icons.add,size: 15,)),
                      
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              children: [
                IconButton(onPressed: ()async {
                  await cartView.deleteCartUiHandler(context: context, cartId: widget.cartId);
                  cartView.cartScreenUiHandler(context);
                }, 
                icon:cartView.isLoading?CircularProgressIndicator(color: kBlackColor,): Icon(Icons.delete_outlined)),
                IconButton(
                    onPressed: () async{

                      await singleProductView.wishlist(product_id: widget.productId, context: context);
                      
                    }, icon:singleProductView.isLoading?CircularProgressIndicator(color: kBlackColor,):
                    isFavorite?Icon(Icons.favorite,color: kBlackColor,): Icon(Icons.favorite_outline_outlined)),
              ],
            )
          ],
        ),
      ),
    );
    
  }
}
