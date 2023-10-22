

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
class Add_route extends StatefulWidget {
  const Add_route({super.key});

  @override
  State<Add_route> createState() => _Add_routeState();
}

class _Add_routeState extends State<Add_route> {
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
  final FocusNode nameFocusNode = FocusNode();
  @override
  @override
  Widget build(BuildContext context) {

    ThemeData(
      // Define your theme properties here
      primaryColor: Color(0xff3553C0),
      fontFamily: 'Roboto',
    );
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
                  "ADD Route",
                  style: TextStyle(
                      color: primarycolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
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
                        Add_srdata();
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







  Add_srdata() async {

    CollectionReference routecollection = FirebaseFirestore.instance.collection('route');

    // Add the new document with an incremented user_id
    await routecollection.add({
      'name': nameController.text,
    });
    showdialogs(this.context,"dailog","Added Successful");
    Navigator.pushNamed(this.context, '/add_sr');
   }
}
