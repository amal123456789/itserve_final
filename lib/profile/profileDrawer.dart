import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';
import 'package:itservpfeapp/registrationAuthentification/TokenModel.dart';
import 'package:itservpfeapp/themes.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileDrawerState();
  }
}

class ProfileDrawerState extends State<ProfileDrawer> {
  Future<TokenModel> loadProfile() async {
    var sessionStorageService = await SessionStorageService.getInstance();
    var role = sessionStorageService.retriveProfile();
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadProfile(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            final TokenModel profile = asyncSnapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'User Profile',
                  style: textHint2,
                ),
                backgroundColor: Colors.blueGrey[100],
              ),
              body: Container(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Name: ",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(profile.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.lime)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Role: ",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(profile.role[0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.lime)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Email: ",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(profile.email,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.lime)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Row(
                        //   children: [
                        //     Text("Name",
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold, height: 3)),
                        //     SizedBox(
                        //       height: defaultPadding,
                        //       width: defaultPadding,
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(profile.name,
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 20,
                        //             color: Colors.lime))
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text("Role",
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold, height: 3)),
                        //     SizedBox(
                        //       height: defaultPadding,
                        //       width: defaultPadding,
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(profile.role[0],
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 20,
                        //             color: Colors.lime))
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text("Email",
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold, height: 3)),
                        //     SizedBox(
                        //       height: defaultPadding,
                        //       width: defaultPadding,
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(profile.email,
                        //         textAlign: TextAlign.center,
                        //         style: const TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 20,
                        //             color: Colors.lime))
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
