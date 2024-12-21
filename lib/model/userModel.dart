class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  int? number;
  String? role;
  int? loginId;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.number,
      this.role,
      this.loginId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    role = json['role'];
    loginId = json['login_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['number'] = this.number;
    data['role'] = this.role;
    data['login_id'] = this.loginId;
    return data;
  }
}
