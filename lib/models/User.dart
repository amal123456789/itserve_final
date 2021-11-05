import 'dart:convert';

import 'Role.dart';
import 'UserModel.dart' as roleEnum;
User userJson(String str) =>
  User.fromJson(json.decode(str));
String userToJson(User data) => 
json.encode(data.toJson());
class User{
  int id;
  String username;
  String email;
  String password;
  Set roles = new Set<Role>();
  roleEnum.Role role;

  User({this.id,this.username, this.email, this.password,this.roles,this.role});

 factory User.fromJson(Map<String , dynamic> json) => User(
  id: json["id"],
  username: json["username"],
  email: json["email"],
  password: json["password"],
  roles: json["roles"],
  role: json["role"],
  );
  Map<String, dynamic> toJson() => {
  'id' : id,
  "username" : username,
  "email" : email,
  "password" : password,
  "roles" : roles,
  "role" : role
  };
  int get idd => id;
  String get usernamee => username;
  String get emaill => email;
  String get passwordd => password;
  Set<Role> get roless => roles;
  roleEnum.Role get rolee => role;

}  