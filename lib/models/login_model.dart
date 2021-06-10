class LoginModel {
  bool status;
  String message;
  UserData data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String token;

//  UserData({
//    this.id,
//    this.name,
//    this.email,
//    this.phone,
//    this.image,
//    this.points,
//    this.credit,
//    this.token,
//  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    token = json['access_token'];
  }
}
