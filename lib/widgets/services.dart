import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Future<List<Map<String, dynamic>>> getData(String collecton) async {
  List<Map<String, dynamic>> routes = [];

  CollectionReference routesCollection =
  FirebaseFirestore.instance.collection(collecton);
  QuerySnapshot querySnapshot = await routesCollection.get();

  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    // String uid = documentSnapshot.id;
    // print(uid);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    // data['uid'] = uid;
    routes.add(data);
  }

  return routes;
}