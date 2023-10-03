import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
class Add_sr extends StatefulWidget {
  const Add_sr({super.key});

  @override
  State<Add_sr> createState() => _add_srState();
}

class _add_srState extends State<Add_sr> {

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

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
        title: const Text(
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
                      Text('upoad profile',style: TextStyle(color: Colors.white, fontSize: 16),),

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

                      final nameValue = nameController.text;
                      final emailValue = emailController.text;
                      final headquarterValue = headquarterController.text;
                      final addressValue = addressController.text;
                      final passwordValue = passwordController.text;
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
  Future<int> getLastUserId() async {
    final DocumentSnapshot lastUserIdDoc = await FirebaseFirestore.instance.collection('metadata').doc('lastUserId').get();
    if (lastUserIdDoc.exists) {
      final data = lastUserIdDoc.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
      return data['user_id'] ?? 0; // Use the 'user_id' field or default to 0 if it's null
    } else {
      return 0; // Default starting user_id
    }
  }

  Future<void> updateLastUserId(int newUserId) async {
    await FirebaseFirestore.instance.collection('metadata').doc('lastUserId').set({'user_id': newUserId});
  }

  Add_srdata() async {

    final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    final String? uiduserdata = userCredential.user?.uid;
    // Retrieve the last used user_id
    int lastUserId = await getLastUserId();



    // Create a reference to the 'user' collection and specify the user_id
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('user');

    // Add the new document with an incremented user_id
    await usersCollection.add({
      'user_id': lastUserId + 1,
      'name': nameController.text,
      'email': emailController.text,
      'headquarter': headquarterController.text,
      'address': addressController.text,
      'password': passwordController.text,
      'user_uid' : uiduserdata,
      'user_type' : 2
    });

    // Update the last used user_id
    await updateLastUserId(lastUserId + 1);
  }


}
