import 'package:crm/screen/Add_Customer.dart';
import 'package:crm/screen/Add_product.dart';
import 'package:crm/screen/Add_route.dart';
import 'package:crm/screen/Customer_list.dart';
import 'package:crm/screen/Route_list.dart';
import 'package:crm/screen/add_sr.dart';
import 'package:crm/screen/home_page.dart';
import 'package:crm/screen/list_of_sr.dart';
import 'package:crm/screen/login_page.dart';
import 'package:crm/screen/placeorder.dart';
import 'package:crm/screen/product_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/Sr_list': (context) => Sr_list(),
        '/add_sr': (context) =>Add_sr(),
        '/add_route': (context) => Add_route(),
        '/route_list': (context) => Route_list(),
        '/Add_Customer': (context) => Add_Customer(),
        '/Customer_list': (context) => Customer_list(),
        '/add_product': (context) => Add_product(),
        '/Product_list': (context) => Product_list()
      },
      title: 'CRM',
      theme: ThemeData(
        primaryColor: Color(0xff3553C0), // Set the primary color
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue), // Customize color scheme as needed
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      home: OrderPlacementScreen(),
    );
  }
}
