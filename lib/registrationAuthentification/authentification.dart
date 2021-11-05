import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:itservpfeapp/constants.dart';
import 'package:itservpfeapp/models/User.dart';
import 'package:itservpfeapp/regisANDsignin/button.dart';
import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';
import 'package:itservpfeapp/registrationAuthentification/registration.dart';
import 'package:itservpfeapp/utils/MyAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../themes.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

Future<Map<String, String>> createAuthHeader() async {
  var sessionStorageService = await SessionStorageService.getInstance();
  var accessToken = sessionStorageService.retriveAccessToken();
  if (accessToken == null) {
    debugPrint("No access token in local storage found. Please log in.");
    return null;
  }
  return {"Authorization": "Bearer $accessToken"};
}

Future<User> addEmployee(
    String username, String password, BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var Url = "http://165.227.228.41:8080/projetPfe/api/auth/signin";
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }));

  if (response.statusCode == 200) {
    var sessionStorageService = await SessionStorageService.getInstance();
    sessionStorageService.saveAccessToken(response.body);
    sharedPreferences.getString("accessToken");
  }
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController =
      TextEditingController(text: 'amal');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController =
      TextEditingController(text: '123456789');
  User reg;
  bool checked = true;
  SharedPreferences sharedPreferences;
/////// test test test
  double _formProgress = 0;
  void _showWelcomeScreen() async {
    var auth = await createAuthHeader();
    if (auth == null) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
            title: 'Invalid Sign in',
            content: 'Incorrect User / Password',
          );
        },
      );
    } else {
      Navigator.of(context).pushNamed('/welcome');
    }
  }

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [usernameController, emailController, passwordController];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

///////

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/images/bg_blue.png"),
            ),
            Positioned(
              bottom: -100,
              child: Image.asset(
                "assets/images/bg_grey.png",
                fit: BoxFit.scaleDown,
                width: 300,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/images/bg_orange.png"),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "assets/images/logo1.png",
                      ),
                    ),
                    HeightBox(10),
                    "Sign-IN".text.size(22).blue500.make(),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 40,
                          ),
                          filled: true,
                          labelText: "Full name",
                          // fillColor: Colors.white,
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                            size: 40,
                          ),
                          filled: true,
                          //fillColor: Colors.white,
                          labelText: "Password",
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ).p4().px24(),
                    HStack([
                      FlatButton(
                          child: Text("Sign In"),
                          color: Colors.green[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green[400])),
                          onPressed: () async {
                            ///String email = emailController.text;
                            String password = passwordController.text;
                            String username = usernameController.text;
                            User datas =
                                await addEmployee(username, password, context);
                            usernameController.text = "";

                            passwordController.text = '';

                            setState(() {
                              reg = datas;
                              //MasterPage();
                              _showWelcomeScreen();
                            });
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
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
                      SizedBox(
                        height: defaultPadding,
                        width: defaultPadding,
                      ),
                    ]),
                    HStack([
                      Checkbox(
                        value: checked,
                        onChanged: (bool value) {
                          checked = value;
                        },
                      ),
                      "Remember Me".text.make().py16(),
                    ]),
                    HStack([
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonCustom(
                              text: "Sign Up",
                              width: 78,
                              height: 36,
                              bgColor: blueColor,
                              press: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Registration();
                                }));
                              },
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            ButtonCustom(
                              text: "Forgot Password",
                              width: 159,
                              height: 36,
                              bgColor: orangeColor,
                              press: () {},
                            )
                          ],
                        ),
                      )
                    ]),
                    GestureDetector(
                      onTap: () {
                        print("Sign In");
                      },
                      child: HStack([
                        "Forgot Password?".text.white.makeCentered(),
                      ]).centered().p4(),
                    ),
                    HStack([
                      VxBox(
                              child: FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                        size: 30,
                      ).p20())
                          .blue700
                          .roundedFull
                          .make(),
                      VxBox(
                              child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 25,
                      ).p20())
                          .red700
                          .roundedFull
                          .make()
                          .p4(),
                    ])
                  ],
                ),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()));
          },
          child: Container(
              height: 25,
              color: Colors.lightBlue,
              child: Center(
                  child: "Create a new Account..! Sign Up"
                      .text
                      .white
                      .makeCentered())),
        ),
      ),
    );
  }
}
