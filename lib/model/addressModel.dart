class AddressModel {
  int? id;
  String? userId;
  String? contactName;
  String? phoneNumber;
  String? streetAddress1;
  String? streetAddress2;
  String? city;
  String? state;
  String? country;
  bool? isDefault;

  AddressModel(
      {this.id,
      this.userId,
      this.contactName,
      this.phoneNumber,
      this.streetAddress1,
      this.streetAddress2,
      this.city,
      this.state,
      this.country,
      this.isDefault});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contactName = json['contact_name'];
    phoneNumber = json['phone_number'];
    streetAddress1 = json['street_address1'];
    streetAddress2 = json['street_address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['contact_name'] = this.contactName;
    data['phone_number'] = this.phoneNumber;
    data['street_address1'] = this.streetAddress1;
    data['street_address2'] = this.streetAddress2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['isDefault'] = this.isDefault;
    return data;
  }
}
