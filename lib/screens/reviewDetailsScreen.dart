import 'package:flutter/material.dart';
import 'package:grocery_app/screens/reviewImageGallery.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/singleProductViewModel.dart';
import 'package:provider/provider.dart';

class ReviewDetailScreen extends StatefulWidget {
  final int id;

  ReviewDetailScreen({super.key, required this.id});

  @override
  State<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends State<ReviewDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final singleProductView =
          Provider.of<SingleProductViewModel>(context, listen: false);

      singleProductView.viewReviewUiHandler(
        productId: widget.id,
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final singleProductView = context.watch<SingleProductViewModel>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,
        
        ),
        backgroundColor: kBgColor,
        body: singleProductView.reviews.isEmpty
            ? Center(child: Text("No reviews available"))
            : ListView.builder(
                itemCount: singleProductView.reviews.length,
                itemBuilder: (context, index) {
                  final review = singleProductView.reviews[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.userName ?? "Anonymous",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            review.rating ?? 0,
                            (starIndex) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          review.description ?? "No description provided",
                          style: TextStyle(fontSize: 14),
                        ),
                        if (review.images != null && review.images!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: 
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewImageGallery(
                                  id: widget.id,
       )));
                              },
                              child: Image.network(
                                review.images![0],
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
