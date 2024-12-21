import 'package:grocery_app/model/productModel.dart';

class SearchResult {
  final List<ProductModel>? products;
  final String? errorMessage;

  SearchResult({this.products, this.errorMessage});
}
