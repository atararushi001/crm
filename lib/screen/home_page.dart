import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State <Home_page> createState() => _home_pageState();
}

class _home_pageState extends State<Home_page> {
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
      body:Column(
        children: [
          Center(
          child: Container(
            margin: EdgeInsets.only(top: 50.0),

            width: 320,
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
          SizedBox(height: 20.0), // Add spacing between rows

          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 100,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'Sales',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0), // Add spacing between columns
              Container(
                width: 150,
                height: 100,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Item 2',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
    // Add spacing between rows
          SizedBox(height: 20.0), // Add spacing between rows

          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 100,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Item 3',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0), // Add spacing between columns
              Container(
                width: 150,
                height: 100,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Item 4',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0), // Add spacing between rows
       // Add spacing between rows

          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 100,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Item 5',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.0), // Add spacing between columns
              Container(
                width: 150,
                height: 100,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Item 6',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0), // Add spacing between rows

        ],

      ),
    );
  }
}
