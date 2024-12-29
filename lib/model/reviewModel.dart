class ReviewModel {
  String? userId;
  String? productId;
  String? productName;
  String? userName;
  String? time;
  String? description;
  int? rating;
  List<String>? images;

  ReviewModel(
      {this.userId,
      this.productId,
      this.productName,
      this.userName,
      this.time,
      this.description,
      this.rating,
      this.images});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    userName = json['user_name'];
    time = json['time'];
    description = json['description'];
    rating = json['rating'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['user_name'] = this.userName;
    data['time'] = this.time;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['images'] = this.images;
    return data;
  }
}
