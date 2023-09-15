import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';


class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(
        title: Text('Matrix'),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/profile.jpg'),
          ),
        ],
      ),

      body: Center(
        child: Text('Side Menu Tutorial'),
      ),
    );
  }
}
