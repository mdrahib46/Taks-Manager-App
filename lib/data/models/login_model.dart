// class LoginModel {
//   String? status;
//   List<Data>? data;
//   String? token;
//
//   LoginModel({this.status, this.data, this.token});
//
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     token = json['token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['token'] = this.token;
//     return data;
//   }
// }
//
// class Data {
//   String? sId;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? mobile;
//   String? password;
//   String? photo;
//   String? createdDate;
//
//   Data(
//       {this.sId,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.mobile,
//         this.password,
//         this.photo,
//         this.createdDate});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     email = json['email'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     mobile = json['mobile'];
//     password = json['password'];
//     photo = json['photo'];
//     createdDate = json['createdDate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['email'] = this.email;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['mobile'] = this.mobile;
//     data['password'] = this.password;
//     data['photo'] = this.photo;
//     data['createdDate'] = this.createdDate;
//     return data;
//   }
// }
