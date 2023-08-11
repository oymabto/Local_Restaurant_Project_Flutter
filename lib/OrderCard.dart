/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// OrderCard is a widget that displays the details of an individual order.
/// It shows the items included in the order, the total price, and the status of the order.
/// Also, it allows to assign a driver for delivery if the order is prepared.
class OrderCard extends StatelessWidget {

  /// orderData is a snapshot of the data of an order from Firestore database.
  final DocumentSnapshot orderData;

  const OrderCard({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  /// Function to assign a driver to the order.
  Future<void> assignDriver(BuildContext context) async {

    /// Fetch the list of drivers who are available for delivery from Firestore.
    QuerySnapshot drivers = await FirebaseFirestore.instance
        .collection('drivers')
        .where('availability', isEqualTo: true)
        .get();

    /// Show a dialog to select a driver from the available drivers.
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Driver'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: drivers.docs.map((doc) {
                return ListTile(
                  title: Text(doc['name']),
                  onTap: () {

                    /// When a driver is selected, update the order with the driver's ID
                    /// and change the status to 'Being Delivered'.
                    FirebaseFirestore.instance
                        .doc(orderData.reference.path)
                        .update({
                      'driverID': doc['id'],
                      'isBeingDelivered': true,
                      'status': 'Being Delivered',
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPrepared = orderData['isPrepared'];
    bool isBeingDelivered = orderData['isBeingDelivered'];
    bool isDelivered = orderData['isDelivered'];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${orderData['title']}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            /// Fetch and display the items of the order from Firestore.
            StreamBuilder<QuerySnapshot>(

              stream: orderData.reference.collection('orderItems').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                double totalPrice = 0;
                snapshot.data!.docs.forEach((doc) {
                  double price =
                      (doc.data() as Map<String, dynamic>).containsKey('price')
                          ? doc['price']
                          : 0;
                  int quantity = (doc.data() as Map<String, dynamic>)
                          .containsKey('quantity')
                      ? doc['quantity']
                      : 0;

                  totalPrice += (price * quantity);
                });

                return Column(
                  children: [
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.network(
                              item['imageUrl'],
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              'Status: ${orderData['status']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            /// If the order is prepared but not yet being delivered or delivered,
            /// show the button to assign a driver.
            if (isPrepared && !isBeingDelivered && !isDelivered)
              ElevatedButton(
                onPressed: () => assignDriver(context),
                child: const Text("Assign to a driver"),
              ),
          ],
        ),
      ),
    );
  }
}
