import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_app/CONSTANTS/future.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'COMMON/validators.dart';
import 'SCREENS/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  String email = '', password = '';
  TextEditingController name = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController location = TextEditingController();
  var registerKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration Page",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/logo.jpg',
                        height: 120,
                        width: 70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'LocatoR',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0,
                            fontFamily: 'Pacifico',
                            color: Colors.lightBlue),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      return Validate.nameValidator(value!);
                    },
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Name",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: ph,
                    validator: (value) {
                      return Validate.numberValidator(value!);
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Enter your Ph No",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: location,
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Location",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    validator: (value) {
                      return Validate.emailValidator(value!);
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Email",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      return Validate.pwdValidator(value!);
                    },
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 5,
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(32.0),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showProgress = true;
                        });
                        if (registerKey.currentState!.validate())
                          try {
                            await _auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) {
                              create_user(value.user!.uid, name.text, email,
                                  ph.text, location.text);

                              if (value.user!.uid != null) {
                                Fluttertoast.showToast(
                                    msg: "Successfully Registered to LocatoR",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyLoginPage()),
                                );

                                setState(() {
                                  showProgress = false;
                                });
                              }
                            });
                          } catch (e) {}
                      },
                      minWidth: 200.0,
                      height: 45.0,
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyLoginPage()),
                      );
                    },
                    child: Text(
                      "Already Registred? Login Now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
