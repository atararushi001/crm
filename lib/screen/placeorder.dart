import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';

class OrderPlacementScreen extends StatefulWidget {
  @override
  _OrderPlacementScreenState createState() => _OrderPlacementScreenState();
}

class _OrderPlacementScreenState extends State<OrderPlacementScreen> {
  String selectedProduct = 'test2';
  int quantity = 1;
  List<Map<String, dynamic>> orderList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Product').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                List<String> products = snapshot.data!.docs
                    .map((doc) => doc['product_name'].toString())
                    .toList();

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: DropdownButton<String>(
                    value: selectedProduct,
                    items: products.map((product) {
                      return DropdownMenuItem<String>(
                        value: product,
                        child: Text(
                          product,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProduct = value!;
                      });
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    underline: Container(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Quantity',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  quantity = int.tryParse(value) ?? 0;
                });
              },
            ),
            ElevatedButton(
              onPressed: addToOrder,
              child: Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: placeorder,
              child: Text('Place Order'),
            ),
            SizedBox(height: 10),
            // if (orderList.isNotEmpty)
            //   Text(
            //     'Selected Products:',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // for (var item in orderList)
            //   Text('${item['product']} - Quantity: ${item['quantity']}'),
          ],
        ),
      ),
    );
  }

  void addToOrder() {
    // Check if the selected product is already in the order list
    int existingProductIndex = orderList.indexWhere((item) => item['product'] == selectedProduct);

    if (existingProductIndex != -1) {
      // If the product is already in the order list, update the quantity
      orderList[existingProductIndex]['quantity'] = quantity;
    } else {
      // If the product is not in the order list, add it with the given quantity
      orderList.add({
        'product': selectedProduct,
        'quantity': quantity,
      });
    }

    // Reset the selected product and quantity
    setState(() {
      selectedProduct = 'test2'; // Reset to 'test2' instead of 'selectedProduct'
      quantity = 0;
    });
  }

  Future<void> placeorder() async {
    CollectionReference routecollection = FirebaseFirestore.instance.collection('order');
    int i = 0;

    for (var item in orderList) {
      // Add the product name with an incremented index (i)
      await routecollection.add({
        'product_name $i': item['product'],
        'quantity' : item['quantity']
      });

      i++; // Increment i by 1 for the next product
    }

    showdialogs(this.context, "dialog", "Added Successful");
  }

}
