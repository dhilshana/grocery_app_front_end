class OrderModel {
  int? id;
  String? productId;
  String? userId;
  String? productName;
  String? productPrice;
  String? productImage;
  int? quantity;
  String? orderStatus;
  String? unit;

  OrderModel(
      {this.id,
      this.productId,
      this.userId,
      this.productName,
      this.productPrice,
      this.productImage,
      this.quantity,
      this.orderStatus,
      this.unit});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    quantity = json['quantity'];
    orderStatus = json['order_status'];
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
    data['quantity'] = this.quantity;
    data['order_status'] = this.orderStatus;
    data['unit'] = this.unit;
    return data;
  }
}
