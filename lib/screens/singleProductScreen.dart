import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screens/addReviewScreen.dart';
import 'package:grocery_app/screens/reviewDetailsScreen.dart';
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
      final singleProductView =
          Provider.of<SingleProductViewModel>(context, listen: false);
      singleProductView.viewSingleProductUiHandler(
          context: context, id: widget.id);
      singleProductView.getWishlistStatus(
          productId: widget.id, context: context);
      singleProductView.viewReviewUiHandler(
          productId: widget.id, context: context);
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
              : singleProduct?.name ?? 'Product Name'),
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
        body: singleProductView.singleProduct == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Image.network(
                                singleProduct?.image ?? 'image',
                                height: 200.h,
                                width: double.infinity,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(singleProduct?.desc ?? 'description'),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      singleProductView.decrement(
                                        fixedprice: double.parse(
                                            singleProduct?.price ?? '0.0'),
                                        fixedquatity: double.parse(
                                            singleProduct?.quantity ?? '1'),
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
                                        fixedprice: double.parse(
                                            singleProduct?.price ?? '0.0'),
                                        fixedquatity: double.parse(
                                            singleProduct?.quantity ?? '1'),
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
                          Row(
                            children: [
                              Text(
                                'Reviews and Ratings',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: List.generate(5, (index) {
                                  // Calculate the average rating
                                  double averageRating =
                                      singleProductView.reviews.isNotEmpty
                                          ? (singleProductView.reviews
                                                  .map((e) => e.rating ?? 0)
                                                  .reduce((a, b) => a + b) /
                                              singleProductView.reviews.length)
                                          : 0;

                                  // Determine if this star should be filled
                                  bool isFilled = index < averageRating.ceil();

                                  return Icon(
                                    isFilled ? Icons.star : Icons.star_border,
                                    color: Colors.amber,
                                    size: 20.sp,
                                  );
                                }),
                              ),
                            ],
                          ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddReviewScreen(
                                                productId: widget.id,
                                              )));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: kGreenColor),
                                  ),
                                  child: Center(child: Text('Add a review')),
                                ),
                              ),
                              SizedBox(height: 20),
                              singleProductView.reviews.isNotEmpty? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: singleProductView.reviews.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewDetailScreen(id: widget.id)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  singleProductView
                                                          .reviews[index]
                                                          .userName ??
                                                      'Anonymous',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  singleProductView
                                                          .reviews[index]
                                                          .description ??
                                                      'No Description',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: List.generate(
                                                  singleProductView
                                                          .reviews[index]
                                                          .rating ??
                                                      0,
                                                  (starIndex) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18.sp,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              singleProductView
                                                      .reviews[index]
                                                      .images!
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      singleProductView
                                                          .reviews[index]
                                                          .images![0],
                                                      width: 100.w,
                                                      height: 70.h,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ):Center(child: Text('No Review Yet'),),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kGreenColor,
                            borderRadius: BorderRadius.circular(10),
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
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
