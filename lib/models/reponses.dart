import 'dart:convert';

JwtResponse jwtResponseJson(String str) =>
  JwtResponse.fromJson(json.decode(str));
String jwtResponseToJson(JwtResponse data) => 
json.encode(data.toJson());
class JwtResponse {
	 String token;
	 String type = "Bearer";
	 int id;
	 String username;
	String email;
	 List<String> roles;

   JwtResponse({this.id, this.email, this.token, this.type, this.username, this.roles});
factory JwtResponse.fromJson(Map<String , dynamic> json) => JwtResponse(

  id: json["id"],
  username: json["username"],
  email: json["email"],
  token: json["token"],
  type: json["type"],
  roles: json["roles"]
);
Map<String, dynamic> toJson() => {
  'id' : id,
  "username" : username,
  "email" : email,
  "token" : token,
  "type" : type,
  "roles" : roles
};
int get idd => id;
  String get usernamee => username;
  String get emaill => email;
  String get tokenn => token;
  String get typee => type;
   List<String> get roless=> roles;

}