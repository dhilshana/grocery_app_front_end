import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/singleProductViewModel.dart';
import 'package:provider/provider.dart';

class SingleProductScreen extends StatefulWidget {
  final int id;

  SingleProductScreen({super.key, required this.id});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  TextEditingController reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final singleProductView = Provider.of<SingleProductViewModel>(context, listen: false);
      singleProductView.viewSingleProductUiHandler(context: context, id: widget.id);
      singleProductView.getWishlistStatus(productId: widget.id, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final singleProductView = context.watch<SingleProductViewModel>();
    final singleProduct = singleProductView.singleProduct;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: kGreenColor,
          foregroundColor: kWhiteColor,
          title: Text(singleProductView.singleProduct == null
              ? 'Loading...'
              : singleProduct?.name ?? 'name'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                singleProductView.wishlist(
                  product_id: singleProduct?.id ?? 0,
                  context: context,
                );
              },
              icon: singleProductView.isLoading
                  ? CircularProgressIndicator(color: kWhiteColor)
                  : (singleProductView.wishlistStatusMap[widget.id] ?? false
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_outline)),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: singleProductView.singleProduct == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Image.network(
                            singleProduct?.image ?? 'image',
                            height: 200.h,
                          ),
                        ),
                        kSizedboxHeight,
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        kHeightInTextField,
                        Text(
                          singleProduct?.desc ?? 'description',
                          softWrap: true,
                        ),
                        kSizedboxHeight,
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                singleProductView.decrement(
                                  fixedprice: double.parse(singleProduct?.price ?? '0.0'),
                                  fixedquatity: double.parse(singleProduct?.quantity ?? '1'),
                                  context: context,
                                );
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(
                              '${singleProductView.quantity} ${singleProduct?.unit}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                singleProductView.increment(
                                  fixedprice: double.parse(singleProduct?.price ?? '0.0'),
                                  fixedquatity: double.parse(singleProduct?.quantity ?? '1'),
                                  context: context,
                                );
                              },
                              icon: Icon(Icons.add),
                            ),
                            Spacer(),
                            Text(
                              '₹${singleProductView.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        kSizedboxHeight,
                        
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kGreenColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 3),
                              blurRadius: 5,
                              color: kShadowColor,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            singleProductView.addToCart(
                              productId: singleProduct?.id ?? 0,
                              context: context,
                            );
                          },
                          child: singleProductView.addToCartLoading
                              ? CircularProgressIndicator(color: kWhiteColor)
                              : Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      color: kWhiteColor, fontSize: 18.sp),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
