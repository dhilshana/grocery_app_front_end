import 'package:flutter/material.dart';
import 'package:grocery_app/model/productModel.dart';
import 'package:grocery_app/model/searchResult.dart';
import 'package:grocery_app/services/apiServices.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  bool isLoading = false;
  ApiServices apiServices = ApiServices();
  List<ProductModel> products = [];

  void viewProductsUiHandler(
      {required int categoryId, required BuildContext context}) async {
    try {
      isLoading = true;
      products =
          await apiServices.getProductsByCategory(categoryId: categoryId);

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void viewSearchedProductUiHandler(
      {required query, required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      products = [];
      notifyListeners();
      SearchResult result = await apiServices.getSearchedProduct(query: query);
      if (result.products != null) {
        products = result.products!; // Assign the list of products
      } else {
        // Handle the error case (e.g., show error message)
        String errorMessage = result.errorMessage ?? 'Something went wrong';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
