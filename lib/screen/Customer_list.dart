import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';

class Customer_list extends StatefulWidget {
  const Customer_list({Key? key}) : super(key: key);

  @override
  _CustomerListState createState() => _CustomerListState();
}

Future<List<Map<String, dynamic>>> getRouteData(BuildContext context) async {
  List<Map<String, dynamic>> routes = [];
  try {
    Map? data = ModalRoute.of(context)!.settings.arguments as Map?;
    if (data == null || data['uid'] == null) {
      print('Invalid data or UID is null.');
      return routes;
    }
    String uid = data['uid']; // Extract 'uid' separately for logging

    CollectionReference customersCollection = FirebaseFirestore.instance.collection('Customer');
    QuerySnapshot querySnapshot = await customersCollection.where('route_uid', isEqualTo: uid).get();

    print('UID: $uid'); // Log the UID
    print('Number of Documents: ${querySnapshot.size}'); // Log the number of documents

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> documentData = documentSnapshot.data() as Map<String, dynamic>;
      routes.add(documentData);
    }
  } catch (e, stackTrace) {
    print('Error fetching data: $e');
    print('Stack Trace: $stackTrace');
  }

  return routes;
}


class _CustomerListState extends State<Customer_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getRouteData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            List<Map<String, dynamic>> routes = snapshot.data!;
            return ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                return buildLocationTile(routes[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map? routedata = ModalRoute.of(context)!.settings.arguments as Map?;
          Navigator.pushNamed(context, '/Add_Customer', arguments: routedata);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildLocationTile(Map<String, dynamic> route) {
    Color iconColor = Color(0xFF3553C0);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: iconColor,
            ),
            Icon(
              Icons.location_city,
              color: iconColor,
            ),
          ],
        ),
        title: Text(route['name']),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Container(
          height: 28,
          margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: IconButton(
            icon: Icon(
              Icons.edit,
              color: iconColor,
            ),
            iconSize: 22.0,
            onPressed: () {
              // Add edit action here
            },
          ),
        ),
        Container(
            height: 28,

        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: iconColor,
          ),
          iconSize: 21.0,
          onPressed: () {
            // Add delete action here
          },
        ),
      ),
      ],
    ),
    onTap: () {
      Navigator.pushNamed(context, '/Add_Customer', arguments: route);
    },
    ),
    );
  }
}
