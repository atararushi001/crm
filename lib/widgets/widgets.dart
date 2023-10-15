


import 'package:flutter/material.dart';
const  primarycolorbtn = Color(0xff3553C0);
const  errorcolor = Color(0xff3553C0);
const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),

  focusedBorder: OutlineInputBorder(

    borderSide: BorderSide(color: primarycolorbtn,width: 3),
    // borderRadius: BorderRadius.circular(10,30,44,20),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primarycolorbtn,width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primarycolorbtn,width: 2),
  ),
);
var primarycolor = Color(0xff3553C0);
var appbar =  AppBar(
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
      width: 20,
      height: 50,
    ),
  ],
);
Future showdialogs(context,String titletext , String contenttext) {
  return showDialog(
    context: context,
    builder: (ctx) =>
        AlertDialog(
          title:  Text(titletext),
          content: Text(contenttext),
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