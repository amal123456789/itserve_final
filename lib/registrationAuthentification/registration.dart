import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/constants.dart';
import 'package:itservpfeapp/models/User.dart';
import 'package:itservpfeapp/regisANDsignin/button.dart';
import 'package:itservpfeapp/registrationAuthentification/authentification.dart';
import 'package:itservpfeapp/utils/MyAlertDialog.dart';
import 'package:itservpfeapp/utils/validators.dart';
import 'package:velocity_x/velocity_x.dart';

import '../themes.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

Future<User> addEmployee(String username, String email, String password,
    String roles, BuildContext context) async {
  var Url = "http://165.227.228.41:8080/projetPfe/api/auth/signup";
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "username": username,
        "email": email,
        "password": password,
        "role": [roles],
      }));

  String responseString = response.body;
  print(response.statusCode);
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return MyAlertDialog(title: 'Backend Response', content: responseString);
    },
  );
}

class _RegistrationState extends State<Registration> {
  bool checked = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userRole = 'admin';
  // final roles = ['admin', 'user'];
  User reg;

  String validateForm() {
    var validator = Validators();
    if (!validator.isNameValid(usernameController.text))
      return 'User Name is not valid';
    if (!validator.isEmailValid(emailController.text))
      return 'Email is not valid';
    if (!validator.isPasswordValid(passwordController.text))
      return 'Password length must be at least 8';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: size.height,
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [const Color(0XFFF95A3B), const Color(0XFFF96713)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 0.8],
                tileMode: TileMode.mirror),
          ),*/
          child: Stack(children: [
            Positioned(
              top: -20,
              child: Image.asset(
                "assets/images/eclipse_top.png",
                fit: BoxFit.fill,
                width: 500,
              ),
            ),
            Positioned(
                bottom: -10,
                right: 0,
                child: Image.asset(
                  "assets/images/eclipse_bottom.png",
                  width: 500,
                )),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 10,
                          height: 20.01,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/icons/arrow_back.png"))),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          child: Text(
                            "Create\nAccount",
                            style: textHeader,
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            "assets/images/logo1.png",
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Full name",
                          // fillColor: Colors.white,
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Email",
                          //fillColor: Colors.white,
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          //fillColor: Colors.white,
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                    // Container(
                    //     padding:
                    //         EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         border: Border.all(width: 1)),
                    //     child: DropdownButtonHideUnderline(
                    //       child: DropdownButton<String>(
                    //         value: userRole,
                    //         isExpanded: true,
                    //         iconSize: 40,
                    //         hint: Text(
                    //           "Role",
                    //         ),
                    //         items: roles.map((String item) {
                    //           return DropdownMenuItem<String>(
                    //             value: item,
                    //             child: new Text(item.capitalizeFirst),
                    //           );
                    //         }).toList(),
                    //         onChanged: (String newValue) {
                    //           setState(() {
                    //             userRole = newValue;
                    //             debugPrint('new role $userRole');
                    //           });
                    //         },
                    //       ),
                    //     )).p4().px24(),

                    ///test radi for roles
                    HStack([
                      Checkbox(
                        value: checked,
                        onChanged: (bool value) {
                          checked = value;
                        },
                      ),
                      "Agree & Continue".text.make().py16()
                    ]),
                    HStack([
                      FlatButton(
                          child: Text("Register"),
                          color: Colors.green[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green[400])),
                          onPressed: () async {
                            String username = usernameController.text;
                            String email = emailController.text;
                            String password = passwordController.text;
                            String roles = userRole;
                            String result = validateForm();
                            if (result == null) {
                              User datas = await addEmployee(
                                  username, email, password, roles, context);
                              usernameController.text = '';
                              emailController.text = '';
                              passwordController.text = '';
                              setState(() {
                                reg = datas;
                              });
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext dialogContext) {
                                  return MyAlertDialog(
                                    title: 'Invalid Data',
                                    content: result,
                                  );
                                },
                              );
                            }
                          }),
                      SizedBox(
                        height: defaultPadding,
                        width: defaultPadding,
                      ),
                      FlatButton(
                          child: Text("Cancel"),
                          color: Colors.red[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red[900])),
                          onPressed: () {}),
                    ]),
                    /*HStack([
                      VxBox(child: "Cancel".text.white.makeCentered().p16()).red600.roundedLg.make().px16().py16(),
                      VxBox(
                        child: "Register".text.white.makeCentered().p16()).green600.roundedLg.make().px16().py16(),
                    
                    ]),*/
                    SizedBox(
                      height: defaultPadding,
                      width: defaultPadding,
                    ),

                    GestureDetector(
                      onTap: () {
                        print("Sign In");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: HStack([
                        "Already Registered?".text.make(),
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: ButtonCustom(
                                  text: "Sign In",
                                  width: 78,
                                  height: 38,
                                  bgColor: blueColor,
                                  press: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignInPage();
                                    }));
                                  })),
                        ),
                      ]).centered(),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
