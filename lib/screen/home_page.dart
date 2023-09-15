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
    var countgrid = 0;
    var primarycolor = Color(0xff3553C0);
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primarycolor,
        title: Text(
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
      body: Column(
        children: [
          Center(
          child: Container(

            width: 200,
            height: 100,
            color: Colors.blue,

            child: Center(
              child: Text(
                'Target',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
