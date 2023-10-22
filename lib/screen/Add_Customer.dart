

import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
String uid = "";
class Add_Customer extends StatefulWidget {
  const Add_Customer({super.key});

  @override
  State<Add_Customer> createState() => _Add_CustomerState();
}

class _Add_CustomerState extends State<Add_Customer> {

  File? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img != null ? File(img.path) : null;
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController shopController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode shopFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  @override
  @override
  Widget build(BuildContext context) {
    Map? data = ModalRoute.of(context)!.settings.arguments as Map?;
    uid = data?['uid'];
   print(data);
    final formkey = GlobalKey<FormState>();


    var primarycolor = Color(0xff3553C0);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Add Customer",
                  style: TextStyle(
                      color: primarycolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: shopController,
                  focusNode: shopFocusNode,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Shop Name",
                    prefixIcon: Icon(
                      Icons.shop_2,
                      color: primarycolor,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "please enter a valid name " : null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  decoration: textInputDecoration.copyWith(
                    labelText: "name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: primarycolor,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "please enter a valid name " : null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: addressController,
                  focusNode: addressFocusNode,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Address",
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: primarycolor,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "please enter a valid name " : null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Contact number ",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: primarycolor,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "please enter a valid name " : null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Contact Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: primarycolor,
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "please enter a valid name " : null;
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


                      if (formkey.currentState!.validate()) {
                        Add_customerdata();
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







  Add_customerdata() async {

    CollectionReference routecollection =
    FirebaseFirestore.instance.collection('Customer');

    // Add the new document with an incremented user_id
    await routecollection.add({
      'shop': shopController.text,
      'name': nameController.text,
      'adress': addressController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'route_uid': uid,
    });
    Map? data = ModalRoute.of(this.context)!.settings.arguments as Map?;
    showdialogs(this.context,"dailog","Added Successful");
    Navigator.pushNamed(this.context, '/Add_Customer',  arguments:data);
  }
}
