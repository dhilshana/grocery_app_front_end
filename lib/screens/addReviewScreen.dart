import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/addReviewViewModel.dart';
import 'package:provider/provider.dart';

class AddReviewScreen extends StatefulWidget {
  final int productId;
  AddReviewScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddReviewViewModel>(context, listen: false);
    });
  }

  int rating = 1;

  @override
  Widget build(BuildContext context) {
    final addReviewView = context.watch<AddReviewViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please share your opinion about the product',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  elevation: 18,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    controller: descController,
                    cursorColor: Colors.black,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Your review',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'What is your rate?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemSize: 40.h,
                    onRatingUpdate: (ratingValue) {
                      setState(() {
                        rating = ratingValue.toInt();
                      });
                      debugPrint('Rating: $rating');
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 250.h, // Define a fixed height for the GridView
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: addReviewView.images.length + 1,
                    itemBuilder: (context, index) {
                      if (index == addReviewView.images.length) {
                        return GestureDetector(
                          onTap: () {
                            addReviewView.showImageSourceDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.withOpacity(0.5),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(
                                File(addReviewView.images[index].path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // SizedBox(height: 50.h), // Add spacing instead of Spacer
                ElevatedButton(
                  onPressed: () {
                    addReviewView.addReviewUiHandler(
                      productId: widget.productId,
                      description: descController.text,
                      rating: rating,
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    fixedSize: Size(MediaQuery.of(context).size.width, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child:addReviewView.viewReviewLoading?CircularProgressIndicator(color: kWhiteColor,): Text(
                    'Submit',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
