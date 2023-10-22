

import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/services.dart';
import '../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Add_product extends StatefulWidget {
  const Add_product({super.key});

  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {
  File? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img != null ? File(img.path) : null;
    });
  }

  final TextEditingController ProductnameController = TextEditingController();
  final TextEditingController ProductpriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final FocusNode ProductnameFocusNode = FocusNode();
  final FocusNode ProductpriceFocusNode = FocusNode();
  final FocusNode stockFocusNode = FocusNode();
  @override
  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData(
      // Define your theme properties here
      primaryColor: Color(0xff3553C0),
      fontFamily: 'Roboto',
    );
    final formkey = GlobalKey<FormState>();
    String email = "";
    String name = "";
    String password = "";
    var primarycolor = Color(0xff3553C0);
    Map? data = ModalRoute.of(context)!.settings.arguments as Map?;
    if(data != null){
      // print(data['name']);
      // ProductnameController.text = data['name'];
      // .text = data['email'];
      // headquarterController.text = data['email'];
      // addressController.text = data['email'];
      // passwordController.text = data['email'];
    }


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
                Text(data != null ? "Update Product" : "Add Product"  ,
                  style: TextStyle(
                      color: primarycolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: ProductnameController,
                  focusNode: ProductnameFocusNode,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Product Name",
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
                  controller:  ProductpriceController,
                  focusNode: ProductpriceFocusNode,
                  decoration: textInputDecoration.copyWith(
                      labelText: "Product Price",
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: primarycolor,
                      )),
                  validator: (value) {
                    return value!.isEmpty
                        ? "please enter a valid Head Quieter "
                        : null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: stockController,
                  focusNode: stockFocusNode,
                  decoration: textInputDecoration.copyWith(
                      labelText: "Product stock",
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: primarycolor,
                      )),
                  validator: (value) {
                    return value!.isEmpty
                        ? "please enter a valid address "
                        : null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarycolor,
                  ),
                  //if user click this button, user can upload image from gallery
                  onPressed: () {
                    // Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text(
                        'Product Photo',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarycolor,
                    ),
                    onPressed: () {
                      final ProductnameValue = ProductnameController.text;
                      final priceValue = ProductpriceController.text;
                      final stockValue = stockController.text;
                      if (formkey.currentState!.validate()) {
                        // data != null ?  update_srdata() :
                        Add_product()
                        ;
                      }
                    },
                    child:  Text(
                      data != null ? "Update SR" : "Add Product",
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

  Future<int> getLastUserId() async {
    final DocumentSnapshot lastUserIdDoc = await FirebaseFirestore.instance
        .collection('metadata')
        .doc('lastUserId')
        .get();
    if (lastUserIdDoc.exists) {
      final data = lastUserIdDoc.data()
      as Map<String, dynamic>; // Cast to Map<String, dynamic>
      return data['user_id'] ??
          0; // Use the 'user_id' field or default to 0 if it's null
    } else {
      return 0; // Default starting user_id
    }
  }




  Add_product() async {

    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('Product');
    String? productphoto= await uploadphto(image);

    // Add the new document with an incremented user_id
    await usersCollection.add({

      'product_name' : ProductnameController.text,
      'product_price': ProductpriceController.text,
      'product_stock': stockController.text,
      'product_photo' : productphoto

    });

    // Update the last used user_id

    showdialogs(this.context,"dailog","Added Successful");


  }
  // Future<void> update_srdata() async {
  //   Map? data = ModalRoute.of(this.context)!.settings.arguments as Map?;
  //   final int? uiduserdata =  data?['user_uid']?.uid; // Assuming you have this value set
  //
  //   // Create a reference to the 'user' collection in Firestore
  //   CollectionReference usersCollection = FirebaseFirestore.instance.collection('user');
  //
  //   // Find the document to update based on 'user_id' or 'user_uid'
  //   QuerySnapshot userQuery = await usersCollection.where('user_id', isEqualTo: uiduserdata).get();
  //   if (userQuery.docs.isNotEmpty) {
  //     // Update the first document found with the provided user_id or user_uid
  //     DocumentSnapshot userDoc = userQuery.docs[0];
  //     await userDoc.reference.update({
  //       'name': nameController.text,
  //       'email': emailController.text,
  //       'headquarter': headquarterController.text,
  //       'address': addressController.text,
  //       'password': passwordController.text,
  //       'user_type': 2,
  //     });
  //
  //     showdialogs(this.context, "dialog", "Update Successful");
  //   } else {
  //     print('User not found'); // Handle the case when the user to update is not found
  //   }
  // }
}
