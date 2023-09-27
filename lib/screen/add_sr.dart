import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';


class add_sr extends StatefulWidget {
  const add_sr({super.key});

  @override
  State<add_sr> createState() => _add_srState();
}

class _add_srState extends State<add_sr> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController headquarterController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode headquarterFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  @override
  // void dispose() {
  //   // Dispose of the controllers when they are no longer needed to prevent memory leaks.
  //   nameController.dispose();
  //   emailController.dispose();
  //   headquarterController.dispose();
  //   addressController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    theme: ThemeData(
      // Define your theme properties here
      primaryColor:  Color(0xff3553C0),
      fontFamily: 'Roboto',

    );
    final formkey = GlobalKey<FormState>();
    String email = "";
    String name = "";
    String password = "";
    var  primarycolor = Color(0xff3553C0);
    return Scaffold(
      backgroundColor:Colors.white,

      drawer: navbar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primarycolor,
        title: Text(
          'Matrix',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/profile.jpg'),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("ADD SR" , style: TextStyle(color: primarycolor, fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  decoration: textInputDecoration.copyWith(
                      labelText: "name",
                      prefixIcon: Icon(
                        Icons.person,
                        color:primarycolor,
                      ), ),
                  validator: (value) {
                    return value!.isEmpty ?  "please enter a valid name " : null;
                  },


                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  focusNode: emailFocusNode,
                  controller: emailController,
                  decoration:  textInputDecoration.copyWith(
                      labelText: "email",
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: primarycolor,
                      )),
                  validator: (value) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                        ? null
                        : "please enter a valid email ";
                  },

                ),

                const SizedBox(
                  height: 15,
                ),
                TextFormField(

                  controller: headquarterController,
                  focusNode: headquarterFocusNode,
                  decoration:  textInputDecoration.copyWith(

                      labelText: "Head Quieter",
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: primarycolor,
                      )),
                  validator: (value) {
                    return value!.isEmpty ?  "please enter a valid Head Quieter " : null;

                  },

                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller:  addressController,
                  focusNode: addressFocusNode,
                  decoration:  textInputDecoration.copyWith(
                      labelText: "address",
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: primarycolor,
                      )),
                  validator: (value) {
                    return value!.isEmpty ?  "please enter a valid address " : null;

                  },

                ),
                const SizedBox(
                  height: 15,
                ),

                TextFormField(
                  controller:  passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: true,
                  decoration:  textInputDecoration.copyWith(
                      labelText: "password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: primarycolor,
                      )),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'password must be at least 6 characters ';
                    } else {
                      return null;
                    }

                  },

                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarycolor,
                    ),
                    onPressed: () {
                      final nameValue = nameController.text;
                      final emailValue = emailController.text;
                      final headquarterValue = headquarterController.text;
                      final addressValue = addressController.text;
                      final passwordValue = passwordController.text;

                      // Validate and perform the desired action
                      if (formkey.currentState!.validate()) {
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
