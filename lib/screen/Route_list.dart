import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';


class Route_list extends StatefulWidget {
  const Route_list({super.key});

  @override
  State<Route_list> createState() => _Route_listState();
}

class _Route_listState extends State<Route_list> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar:  appbar,
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of locations
        itemBuilder: (context, index) {
          return buildLocationTile();
        },
      ),
    );
  }

  Widget buildLocationTile() {
    Color iconColor = Color(0xFF3553C0);

    return Card(
        elevation: 4.0, // Adjust the elevation for the shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Adjust the radius for rounded corners
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
            title: Text('Route Name'),
            subtitle: Text('Total Customers: 10', style: TextStyle(color: Colors.black87)), // Replace with the actual number of customers
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
              // Add navigation or action when a user is tapped
              // For example, navigate to a detailed user profile page
            },
        ),
        );

  }
}
