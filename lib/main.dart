import 'package:crm/screen/Add_route.dart';
import 'package:crm/screen/Route_list.dart';
import 'package:crm/screen/add_sr.dart';
import 'package:crm/screen/home_page.dart';
import 'package:crm/screen/list_of_sr.dart';
import 'package:crm/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
        '/home': (context) => Home_page(),
        '/login': (context) => LoginPage(),
        '/Sr_list': (context) => Sr_list(),
        '/add_sr': (context) =>Add_sr(),
        '/add_route': (context) => Add_route(),
        '/route_list': (context) => Route_list(),
      },
      title: 'CRM',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      home: Add_route(),
    );
  }
}
