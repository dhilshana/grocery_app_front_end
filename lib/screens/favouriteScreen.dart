import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/customWidgets/favouriteItemWidget.dart';
import 'package:grocery_app/screens/singleProductScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/favouriteViewModel.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
   @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  final favouriteview = Provider.of<FavouriteViewModel>(context, listen: false);
  favouriteview.viewWishlistUiHandler(context: context);
  
  });
}

  @override
  Widget build(BuildContext context) {

    final favouriteview = context.watch<FavouriteViewModel>();

    int l = favouriteview.wishlist.length;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.h,
        
      ),
      backgroundColor: kBgColor,
      body: Padding(padding:const EdgeInsets.all(15),
      child:favouriteview.isLoading?const Center(child: CupertinoActivityIndicator(),):l>0? ListView.builder(
        itemCount: l,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleProductScreen(id: int.parse(favouriteview.wishlist[index].productId??'0'))));
          },
          child: FavouriteItemWidget(image: favouriteview.wishlist[index].productImage??'name', 
          item: favouriteview.wishlist[index].productName??'name', 
          price: '₹${favouriteview.wishlist[index].productPrice}',
          productId:int.parse(favouriteview.wishlist[index].productId??'0') ,),
        );
      },):Center(child: Text(favouriteview.message??'No data available'),)),

    ));
  }
}