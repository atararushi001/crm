import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/services.dart';
import '../widgets/widgets.dart';
import 'add_sr.dart';


class Product_list extends StatefulWidget {
  @override
  State<Product_list> createState() => _Product_listState();
}

class _Product_listState extends State<Product_list> {
  @override
  List<Map> data = [];
  bool _isLoading=true;
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    List<Map> loaddata = await getData('Product');
    setState(() {
      data = loaddata;
      _isLoading = false; // Set isLoading to false when data is loaded
    });
  }


  @override
  Widget build(BuildContext context) {
    var primarycolor = Color(0xff3553C0);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar:  appbar,
      body:
      _isLoading
          ?buildLoadingIndicator()
          :
      Column(
        children: [

          Expanded(
            child: dataList(data: data),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_product');
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class dataList extends StatelessWidget {
  final List<Map> data;

  dataList({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return dataCard(data: data[index]);
      },
    );
  }
}

class dataCard extends StatelessWidget {
  final Map data;

  dataCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data['product_photo']),
        ),
        title: Text(data['product_name']),
        subtitle: Text(data['product_price']),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 28,
              margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: IconButton(
                icon: Icon(Icons.edit),
                iconSize: 22.0,
                onPressed: () {
                   Navigator.pushNamed(context, '/add_product',  arguments:data);
                },
              ),
            ),
            Container(
              height: 28,
              margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: IconButton(
                icon: Icon(Icons.delete),
                iconSize: 21.0,
                onPressed: () {

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
