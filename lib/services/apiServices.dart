import 'dart:convert';

import 'package:grocery_app/model/cartModel.dart';
import 'package:grocery_app/model/categoryModel.dart';
import 'package:grocery_app/model/orderModel.dart';
import 'package:grocery_app/model/productModel.dart';
import 'package:grocery_app/model/searchResult.dart';
import 'package:grocery_app/model/userModel.dart';
import 'package:grocery_app/model/wishlistModel.dart';
import 'package:grocery_app/model/addressModel.dart';
import 'package:grocery_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiServices{

  Future<int?> getId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('token');
  }
  Future<void> deleteId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token'); // Remove the token using its key
}

Future<List<CategoryModel>> getCategory() async{
  String getCategoryUrl = '$baseUrl/viewcategory';
  try{
    final response = await http.get(Uri.parse(getCategoryUrl));
    if(response.statusCode == 200){
      final fulldata = jsonDecode(response.body);
        final List<CategoryModel> modelsdata = (fulldata['data'] as List)
    .map((e) => CategoryModel.fromJson(e))
    .toList();
        return modelsdata;
    }
    else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

  Future<List<ProductModel>> getProducts() async{
    String viewProductUrl = '$baseUrl/viewproducts';
    try{
      final response = await http.get(Uri.parse(viewProductUrl));
      if(response.statusCode == 200){
        final fulldata = jsonDecode(response.body);
        final List<ProductModel> modelsdata = (fulldata['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
        return modelsdata;
      }
      else{
        return jsonDecode(response.body);
      }
    }catch(e){
        print(e);
      rethrow;
    }
  }
  Future<ProductModel> getSingleProduct({required int id}) async{
    String singleProductUrl = '$baseUrl/viewsingleproduct/$id';
    try{      
      final response = await http.get(Uri.parse(singleProductUrl));
      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        final ProductModel singleProduct = ProductModel.fromJson(data['data']);
        
        return singleProduct;
      }
      else{
        return jsonDecode(response.body);
      }
    }catch(e){
      rethrow;
    }
  }
  Future<Map<String,dynamic>> wishlist({required int product_id,required int user_id}) async{
    String wishlistUrl = '$baseUrl/wishlist';
    try{
    final response = await http.post(Uri.parse(wishlistUrl),body: {
      'product_id':product_id.toString(),
      'user_id':user_id.toString()
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
  }
  Future<Map<String,dynamic>> checkWishlistStatus({required int userId,required int productId})async{
    String wishlistStatusUrl = '$baseUrl/checkwishliststatus/$productId/$userId';
    try{
      final response = await http.get(Uri.parse(wishlistStatusUrl));
      final data = jsonDecode(response.body);
      return data;
    }
    catch(e){
      rethrow;
    }
  }

  Future<Map<String,dynamic>> addToCart({required int productId,required int userId})async{
    String addToCartUrl = '$baseUrl/addcart';
    try{
      final response = await http.post(Uri.parse(addToCartUrl),body: {
        'product_id':productId.toString(),
        'user_id':userId.toString(),
      });
      if(response.statusCode == 200){

        return jsonDecode(response.body);
      }else{

        return jsonDecode(response.body);
      }
    }catch(e){
      rethrow;
    }
  }
Future<List<WishlistModel>> getWishlist({required int userId}) async{
  String getWishlistUrl = '$baseUrl/viewwishlist/$userId';
  try{
    final response = await http.get(Uri.parse(getWishlistUrl));

    if(response.statusCode == 200){

        final fulldata = jsonDecode(response.body);
        final List<WishlistModel> modelsdata = (fulldata['data'] as List)
          .map((e) => WishlistModel.fromJson(e))
          .toList();
        return modelsdata;
      }
      else{
        throw jsonDecode(response.body)['message'];
      }
  }catch(e){
    rethrow;
  }
}

Future<CartModel> getCart({required int userId}) async{
  String getCartUrl = '$baseUrl/viewcartbyuserid/$userId';
  try{

    final response = await http.get(Uri.parse(getCartUrl));

    if(response.statusCode == 200){

      final data = jsonDecode(response.body) as Map<String,dynamic>;
      return CartModel.fromJson(data);
    }else{
      return throw Exception('Failed to load cart: ${response.body}');
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> deleteCart({required int cartId,required int userId})async{
  String deleteCartUrl = '$baseUrl/deletecartitem/$userId/$cartId';
  try{
    final response = await http.delete(Uri.parse(deleteCartUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> decrementCart({required int userId,required int cartId}) async{
  String decrementCartUrl = '$baseUrl/decrementcart/$userId/$cartId';
  try{
    final response = await http.put(Uri.parse(decrementCartUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> incrementCart({required int cartId,required int userId}) async{
  String incrementCartUrl = '$baseUrl/incrementcart/$userId/$cartId';
  try{
    final response = await http.put(Uri.parse(incrementCartUrl));
    if(response.statusCode== 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<UserModel> getUserData({required int userId})async{
  String getUserUrl = '$baseUrl/user/$userId';
  try{
    final response = await http.get(Uri.parse(getUserUrl));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as Map<String,dynamic>;
      return UserModel.fromJson(data['data']);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> editProfile({required userId, required String name, required String email, required String phoneNumber})async{
  String editProfileUrl = '$baseUrl/update/$userId';
  try{
    final response = await http.put(Uri.parse(editProfileUrl),body: {
      'name':name,
      'email':email,
      'number':phoneNumber,
    });

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> addOrder({required int userId}) async{
  String addOrderUrl = '$baseUrl/addorder/$userId';
  try{
    final response = await http.post(Uri.parse(addOrderUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<List<OrderModel>> getOrders({required int userId}) async{
  String getOrdersUrl = '$baseUrl/vieworders/$userId';
  try{
    final response = await http.get(Uri.parse(getOrdersUrl));
    if(response.statusCode == 200){
      final fullData = jsonDecode(response.body);
      final List<OrderModel> modelData = (fullData['data'] as List).map((e)=>OrderModel.fromJson(e)).toList();
      return modelData;
    }
    else{
      throw jsonDecode(response.body)['message'];
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> deleteOrder({required int userId,required int orderId}) async{
  String deleteOrderUrl = '$baseUrl/deleteorder/$userId/$orderId';
  try{
    final response = await http.delete(Uri.parse(deleteOrderUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> saveAddress({required int userId,required String name,required String phoneNumber,required String address1,required String address2,required String city,required String state,required String country}) async{
  final saveAddressUrl = '$baseUrl/saveaddress';
  try{
    final response = await http.post(Uri.parse(saveAddressUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<List<AddressModel>> getAddress({required int userId})async{
  String getAddressUrl = '$baseUrl/viewaddressbyuserid/$userId';
  try{
    final response = await http.get(Uri.parse(getAddressUrl));
    if(response.statusCode == 200){
      final fullData = jsonDecode(response.body);

      final List<AddressModel> modelData = (fullData['data'] as List).map((e)=>AddressModel.fromJson(e)).toList();
      return modelData;
    }else{
      throw jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}


Future<Map<String,dynamic>> addAddress({required String userId,required String name,required String phone,required String address1,required String address2,required String city,required String state,required String country})async{
  String addaddressUrl = '$baseUrl/saveaddress';
  try{

  
    final response = await http.post(Uri.parse(addaddressUrl),body: {
      'user_id':userId,
      'name':name,
      'phone_no':phone,
      'address1':address1,
      'address2':address2,
      'city':city,
      'state':state,
      'country':country

    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> deleteSingleAddress({required int userId,required int addressId})async{
  String deleteAddressUrl = '$baseUrl/deletesingleaddress/$userId/$addressId';
  try{
    final response = await http.delete(Uri.parse(deleteAddressUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> deleteAddress({required int userId})async{
  String deleteAddressUrl = '$baseUrl/deleteaddress/$userId';
  try{
    final response = await http.delete(Uri.parse(deleteAddressUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);

    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> updateAddress({required String userId,
required int addressId,
required String name,
required String phone,
required String address1,
required String address2,
required String city,
required String state,
required String country})async{
  String updateAddressUrl = '$baseUrl/updateaddress/$userId/$addressId';
  try{
    final response = await http.put(Uri.parse(updateAddressUrl),body: {
            'contact_name': name,
            'phone_number': phone,
            'street_address1': address1,
            'street_address2': address2,
            'city':city ,
            'state': state,
            'country': country,
            
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}  

Future<Map<String,dynamic>> deleteSingleUser({required int userId})async{
  String deleteSingleUserUrl = '$baseUrl/delete/$userId';
  try{
    final response =await http.delete(Uri.parse(deleteSingleUserUrl));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw 'Unable to delete';
    }
  }catch(e){
    rethrow;
  }
}

Future<List<ProductModel>> getProductsByCategory({required int categoryId}) async{
  String getProductsByCategoryUrl = '$baseUrl/viewproductsbycategoryid/$categoryId';
  try{

     final response = await http.get(Uri.parse(getProductsByCategoryUrl));
      if(response.statusCode == 200){
        final fulldata = jsonDecode(response.body);
        final List<ProductModel> modelsdata = (fulldata['data '] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
        return modelsdata;
      }
      else{
        return jsonDecode(response.body);
      }
    }catch(e){
      rethrow;
  }
}
Future<SearchResult> getSearchedProduct({required String query})async{
  String searchUrl = '$baseUrl/searchproduct';
  try{
    final response = await http.post(Uri.parse(searchUrl),body: {
      'search_query':query
    });
    if(response.statusCode == 200){
      final fullData = jsonDecode(response.body);
      final List<ProductModel> modelsData = (fullData['data'] as List).map((e)=>ProductModel.fromJson(e)).toList();
      return SearchResult(products: modelsData);
    }else{
      return SearchResult(errorMessage: jsonDecode(response.body)['message']);
    }
  }catch(e){
    rethrow;
  }
}

Future<Map<String,dynamic>> addReview({required int productId,required int userId, required String description,required int rating})async{
  String addReviewUrl = '$baseUrl/reviewProduct';
  try{
    final response = await http.post(Uri.parse(addReviewUrl),body: {
      'product_id':productId,
      'user_id':userId,
      'description':description,
      'rating':rating,
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      return jsonDecode(response.body);
    }
  }catch(e){
    rethrow;
  }
}
}