import 'package:flutter/material.dart';
import 'package:grocery_app/customWidgets/productWidget.dart';
import 'package:grocery_app/screens/singleProductScreen.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:grocery_app/view-model/categoryScreenViewModel.dart';
import 'package:provider/provider.dart';

class CategoryDetailScreen extends StatefulWidget {
  int categoryId;
  String category_name;
  CategoryDetailScreen({super.key,required this.categoryId,required this.category_name});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
    @override
void initState() {
  super.initState();
  // Fetch products when the screen is initialized
  final categoryView = Provider.of<CategoryScreenViewModel>(context, listen: false);
  categoryView.viewProductsUiHandler(categoryId: widget.categoryId, context: context);
}
  
  @override
  Widget build(BuildContext context) {
    final categoryView = context.watch<CategoryScreenViewModel>();

    int l = categoryView.products.length;
  
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(widget.category_name,style: TextStyle(
          color: kWhiteColor
           ),),
           centerTitle: true,
      ),
      backgroundColor: kBgColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           TextField(
            onChanged: (value) {
              categoryView.viewSearchedProductUiHandler(query: value, context: context);
            },
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
          
           ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleProductScreen(id:categoryView.products[index].id??0,)));
                  },
                  child: ProductWidget(
                    title: categoryView.products[index].name??'name',
                    image: categoryView.products[index].image??'image',
                    price:categoryView.products[index].price??'price',
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