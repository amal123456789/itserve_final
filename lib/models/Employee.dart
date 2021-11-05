import 'dart:convert';

Employee employeeJson(String str) =>
    Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => 
json.encode(data.toJson());




class Employee {
  int id;
  String firstName;
  String lastName;
 
  Employee({this.id, this.firstName, this.lastName});
 
  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      firstName: json["firstName"],
       lastName: json["lastName"],
        id: json["id"]);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        'id': id,
      };

  String get firstname => firstName;

  String get lastname => lastName;
}