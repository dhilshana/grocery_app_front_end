import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/categoryWidget.dart';
import 'package:grocery_app/customWidgets/productWidget.dart';
import 'package:grocery_app/screens/categoryDetailScreen.dart';
import 'package:grocery_app/screens/singleProductScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/userHomeViewModel.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  @override
void initState() {
  super.initState();
  // Fetch products when the screen is initialized
  final homeview = Provider.of<Userhomeviewmodel>(context, listen: false);
  homeview.viewProductsUiHandler(context);
  homeview.viewCategoryUiHandler(context);
}

  @override
  Widget build(BuildContext context) {

    final homeview = context.watch<Userhomeviewmodel>();

    int l = homeview.products.length;
    return SafeArea(child: Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: kShadowColor
              ),
              contentPadding: EdgeInsets.all(10),
              fillColor: kWhiteColor,
              filled: true,
              
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: kShadowColor)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: kShadowColor)),
                  
            ),
            onChanged: (value) {
              homeview.viewSearchedProductUiHandler(query: value, context: context);
            },
          
           ),
           kSizedboxHeight,
           Container(
            height: 150.h,
             child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeview.category.length,
              itemBuilder: (context, index) {
                
               return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetailScreen(categoryId: homeview.category[index].id??0,category_name: homeview.category[index].categoryName??'category_name',)));
                },
                 child: CategoryWidget(
                  category: homeview.category[index],
                 ),
               );
             },),
           ),
           Text('All',style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500
           ),),
           kSizedboxHeight,
           Expanded(
             child: l>0? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              ),
              itemCount: l,
              itemBuilder: (context, index) {
                
              
              return  GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleProductScreen(id: homeview.products[index].id??0,)));
                  },
                  child: ProductWidget(
                    title: homeview.products[index].name??'name',
                    image: homeview.products[index].image??'image',
                    price:homeview.products[index].price??'price',
                  ));
                 
              }
              ):Center(
                child: Text('No products available'),
              )
           )
          ],
        ),
      ),
    ));
  }
}