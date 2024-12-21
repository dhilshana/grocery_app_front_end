class WishlistModel {
  int? id;
  String? productId;
  String? userId;
  String? productName;
  String? productPrice;
  String? productImage;

  WishlistModel(
      {this.id,
      this.productId,
      this.userId,
      this.productName,
      this.productPrice,
      this.productImage});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    return data;
  }
}
