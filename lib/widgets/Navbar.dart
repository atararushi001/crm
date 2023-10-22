import 'package:flutter/material.dart';

class navbar extends StatelessWidget {
  const navbar({super.key});

  @override
  Widget build(BuildContext context) {
    var primarycolor = Color(0xff3553C0);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'welcome',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: primarycolor,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => {
                    Navigator.pushNamed(context, '/home'),
                  }),
          ListTile(
              leading: Icon(Icons.edit_note),
              title: Text('SR management'),
              onTap: () => {
                    Navigator.pushNamed(context, '/Sr_list'),
                  }),
          ListTile(
              leading: Icon(Icons.card_travel_sharp),
              title: Text('Product'),
              onTap: () => {
                    Navigator.pushNamed(context, '/home'),
                  }),
          ListTile(
              leading: Icon(Icons.add_business_rounded),
              title: Text('Routes'),
              onTap: () => {
                    Navigator.pushNamed(context, '/route_list'),
                  }),
          ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text('Customer'),
              onTap: () => {
                    Navigator.pushNamed(context, '/Customer_list'),
                  }),
          ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Target'),
              onTap: () => {
                    Navigator.pushNamed(context, '/home'),
                  }),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => {
                    Navigator.pushNamed(context, '/login'),
                  }),
        ],
      ),
    );
  }
}
