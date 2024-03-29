import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';

class Route_list extends StatefulWidget {
  const Route_list({super.key});

  @override
  State<Route_list> createState() => _Route_listState();
}

Future<List<Map<String, dynamic>>> getRouteData() async {
  List<Map<String, dynamic>> routes = [];

  CollectionReference routesCollection =
      FirebaseFirestore.instance.collection('route');
  QuerySnapshot querySnapshot = await routesCollection.get();

  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    String uid = documentSnapshot.id;
    // print(uid);
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    data['uid'] = uid;
    routes.add(data);
  }

  return routes;
}

class _Route_listState extends State<Route_list> {
  bool _isLoading = true;
  List<Map<String, dynamic>> routes = [];

  @override
  void initState() {
    super.initState();
    _loadRouteData();
  }

  Future<void> _loadRouteData() async {
    List<Map<String, dynamic>> loadedRoutes = await getRouteData();
    setState(() {
      routes = loadedRoutes;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
     // print(credential['user_type']);



    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: _isLoading
          ? buildLoadingIndicator()
          : ListView.builder(
              itemCount: routes.length,
              itemBuilder: (context, index) {
                return buildLocationTile(routes[index]);
              },
            ),

      floatingActionButton:
      credential['user_type'] == 0 ?
      Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_route');
            },
            child: Icon(Icons.add),
          ),
        ),
      )
          :  Center()
    );
  }

  Widget buildLocationTile(Map<String, dynamic> route) {
    Color iconColor = Color(0xFF3553C0);
// print(route);
    return Card(
      elevation: 4.0, // Adjust the elevation for the shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            12.0), // Adjust the radius for rounded corners
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: iconColor,
            ),
            Icon(
              Icons.person,
              color: iconColor,
            ), // Customer icon
          ],
        ),
        title: Text(route['name']),
        subtitle: Text('Total Customers: 10',
            style: TextStyle(
                color: Colors.black87)), // Replace with the actual number of customers
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
              margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
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
          // credential['user_type'] ==2 ?
          // Navigator.pushNamed(context, '/Add_Customer',  arguments:route)
          // :
          Navigator.pushNamed(context, '/Customer_list',  arguments:route);
        },
      ),
    );
  }
}
