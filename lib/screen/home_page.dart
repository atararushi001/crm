import 'package:flutter/material.dart';
import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';
import 'Route_list.dart';
import 'Sales_page.dart';
import 'list_of_sr.dart';
// Import the correct page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var primaryColor = Color(0xff3553C0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to SRPage when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sr_list()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                width: 380,
                height: 140,
                child: Card(
                  color: Colors.white,
                  elevation: 5, // Add a slight shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Add rounded corners
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'assets/dataicons/target.png',
                                width: 155, // Adjust the width as needed
                                height: 140, // Adjust the height as needed
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 29, // Increased font size
                                        ),
                                      ),
                                      Text(
                                        '****/',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18, // Adjust the font size
                                        ),
                                      ),
                                      Text(
                                        '****',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 18, // Adjust the font size
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Target',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
              buildClickableIconContainer('assets/dataicons/sr.png', 'SR', Sr_list()),
              SizedBox(width: 20.0), // Add spacing between columns
              buildClickableIconContainer('assets/dataicons/route.png', 'Route', Route_list()),
            ],
          ),
          SizedBox(height: 20.0), // Add spacing between rows

          // Row 2
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildClickableIconContainer('assets/dataicons/sales.png', 'Sales', SalesPage()),
              SizedBox(width: 20.0),
              buildClickableIconContainer('assets/dataicons/customer.png', 'Customer', Sr_list()),
            ],
          ),
          SizedBox(height: 20.0), // Add spacing between rows
        ],
      ),
    );
  }

  Widget buildClickableIconContainer(String imagePath, String text, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        // Navigate to the determined page when clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        width: 160,
        height: 130,
        child: Card(
          color: Colors.white,
          elevation: 5, // Add a slight shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Add rounded corners
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: 80, // Adjust the width as needed
                    height: 80, // Adjust the height as needed
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}