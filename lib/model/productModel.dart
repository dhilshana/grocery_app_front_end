class ProductModel {
  int? id;
  String? name;
  String? price;
  String? image;
  int? category;
  String? desc;
  String? quantity;
  String? unit;

  ProductModel({this.id, this.name, this.price, this.image, this.category,required this.desc,required this.quantity,required this.unit});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    category = json['category'];
    desc = json['desc'];
    quantity = json['quantity'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['category'] = this.category;
    data['desc'] = this.desc;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    return data;
  }
}
