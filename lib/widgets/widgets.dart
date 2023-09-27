
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

