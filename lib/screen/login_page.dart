import 'package:crm/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff3553C0);
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Form(
                key: formKey,
                child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.blue,
                      child: Column(

                        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                        children: [
                          Image.asset(
                            "assets/img/crmlogo.png",
                            width: 200,
                            height: 200,
                          ),
                          Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(

                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Text("Welcome Back" , textAlign: TextAlign.left, style: TextStyle(color: primaryColor, fontSize: 30,fontWeight: FontWeight.bold),),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    decoration: InputDecoration(

                                      labelText: "email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    validator: (value) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value!)
                                          ? null
                                          : "please enter a valid email ";
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 500.0,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(

                                      labelText: "password",
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length < 6) {
                                        return 'password must be at least 6 characters ';
                                      } else {
                                        return null;
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(

                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      login();
                                    },
                                    child: const Text(
                                      "Login ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton.icon(
                                    onPressed: (){

                                    },
                                    icon: Image.asset(
                                      "assets/img/google.png",
                                      width: 20,
                                    ),
                                    label: Text('Sign in with Google'),
                                    style: ElevatedButton.styleFrom(
                                      primary:   Theme.of(context).primaryColor,// Change the button's background color
                                      onPrimary: Colors.white, // Change the text color
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void userLogedin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const Home_page(),
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      // print(email);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        userLogedin();
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Login Unsuccessful"),
              content: const Text("Please recheck Login ID and Password"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(14),
                    child: const Text("DONE"),
                  ),
                ),
              ],
            ),
          );
        } else if (e.code == 'wrong-password') {
          // print('Wrong password provided for that user.');
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Login Unsuccessful"),
              content: const Text("Please recheck  Password"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(14),
                    child: const Text("DONE"),
                  ),
                ),
              ],
            ),
          );
        }
      }
    }
  }
}
