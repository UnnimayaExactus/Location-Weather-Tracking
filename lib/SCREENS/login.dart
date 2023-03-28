import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../COMMON/validators.dart';
import 'homepage.dart';

void main() => runApp(MyApp());
String UserID = '';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _auth = FirebaseAuth.instance;

  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icons/logo.jpg',
                  height: 250,
                  width: 300,
                ),
                Text(
                  'LocatoR',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30.0,
                      fontFamily: 'Pacifico',
                      color: Colors.lightBlue),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validate.emailValidator(value!);
                  },
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value; // get value from TextField
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    return Validate.pwdValidator(value!);
                  },
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value; //get value from textField
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  elevation: 5,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(32.0),
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        UserID = newUser.user!.uid;
                        print(newUser.toString());
                        print('//////////////${UserID.toString()}');

                        if (newUser != null) {
                          Fluttertoast.showToast(
                              msg: "Login Successfull",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()),
                            );
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Invalid User",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              // timeInSecForIos: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              fontSize: 16.0);
                        }
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'Invalid Username/Password',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 4,
                            backgroundColor: Colors.white,
                            textColor: Colors.red,
                            fontSize: 16.0);
                      }
                    },
                    minWidth: 200.0,
                    height: 45.0,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
