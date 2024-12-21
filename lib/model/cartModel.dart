class CartModel {
  List<Data>? data;
  double? totalPrice;

  CartModel({this.data, this.totalPrice});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalPrice = json['Total Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Total Price'] = this.totalPrice;
    return data;
  }
}

class Data {
  int? id;
  String? productId;
  String? userId;
  String? productName;
  String? productPrice;
  String? productImage;
  String? cartStatus;
  int? quantity;
  String? unit;

  Data(
      {this.id,
      this.productId,
      this.userId,
      this.productName,
      this.productPrice,
      this.productImage,
      this.cartStatus,
      this.quantity,
      this.unit});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    cartStatus = json['cart_status'];
    quantity = json['quantity'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['cart_status'] = this.cartStatus;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    return data;
  }
}
