/// Done by Ian

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DriverBottomNavigationBar.dart';
import 'main.dart';

/// This CurrentDeliveryPage is a StatelessWidget that is responsible for the
/// Current Delivery Page screen for the logged in driver. It has a
/// num _totalPrice(docs) function that calculates the total price of the order,
/// and a num _totalPriceWithTip(totalPrice) that calculates the total price
/// with tip. It has a built in Scaffold() with appBar, body, and
/// bottomNavigationBar. We use nested StreamBuilders to select the correct data
/// from the database, and pass it directly to the UI of the screen.
class CurrentDeliveryPage extends StatelessWidget {
  const CurrentDeliveryPage({super.key, required this.title});

  final String title;

  /// This function _totalPrice takes docs as a parameter that allows us to
  /// connect to the correct collection in our database and retrieve the correct
  /// documents. We iterate through them to find the total price of the order by
  /// multiplying price and quantity, and adding it to the running total. We then
  /// multiply by a tax of 15 % and round it to the nearest cent. The output is
  /// num totalPrice, the total price for the order with tax included.
  num _totalPrice(docs) {
    /// Start the running total at $0.00.
    num totalPrice = 0.0;
    /// Iterate through all documents in the selected collection, find the price
    /// for "suborder" that is a quantity of the same item at the same price, and
    /// add to the running total. This is one of the quantities shown on the
    /// Current Delivery page.
    for (var doc in docs) {
      totalPrice += doc['price'] * doc['quantity'];
    }
    /// Include tax which is 15 %.
    totalPrice *= 1.15;
    /// Round to the nearest cent.
    totalPrice = (totalPrice * 100).round() / 100.0;
    return totalPrice;
  }

  /// This function _totalPriceWithTip takes num totalPrice from the function
  /// above and calculates what the price will be if we are to include a 15 % tip,
  /// rounded to the nearest cent. We return num totalPriceWithTip. This is one
  /// of the quantities shown on the Current Delivery page.
  num _totalPriceWithTip(totalPrice) {
    num totalPriceWithTip = totalPrice * 1.15;
    totalPriceWithTip = (totalPriceWithTip * 100).round() / 100.0;
    return totalPriceWithTip;
  }

  @override
  Widget build(BuildContext context) {
    /// These Strings are for the logged in user which correspond to the data in
    /// the database. Here we get the id of the driver that is logged in.
    String driverId = Provider.of<EmployeeInfo>(context).id;
    /// We get the first name of the user that is logged in.
    String driverName = Provider.of<EmployeeInfo>(context).name;
    /// We get the last name of the user that is logged in.
    String driverFamily = Provider.of<EmployeeInfo>(context).family;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, 'DriverDashboard');
        return false;
      },
      /// Create the Scaffold().
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Current Delivery"),

              /// This Text widget will display the driver's name and family name.
              Text("$driverName $driverFamily",
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        /// Center the layout.
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 24),
          /// Info in 2 columns in a row.
          StreamBuilder<QuerySnapshot>(
            /// We select the orders collection, where the driverID is the same
            /// as the logged in driver user, for orders that are being delivered,
            /// and are not yet delivered.
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('driverID', isEqualTo: driverId)
                  .where('isBeingDelivered', isEqualTo: true)
                  .where('isDelivered', isEqualTo: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }

                /// Figure out how to have no data pulled from here: https://stackoverflow.com/questions/60989203/flutter-how-to-show-a-message-if-snapshot-has-no-data
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data?.size == 0) {
                  return const Center(child: Text("No current delivery"));
                } else {
                  var orderNumber = snapshot.data!.docs.first.id;
                  var streetAddress =
                      snapshot.data!.docs.first['streetAddress'];
                  var cityAddress = snapshot.data!.docs.first['cityAddress'];

                  /// To make is easier to have access to the previous stream
                  var orderDoc = snapshot.data!.docs.first;
                  return StreamBuilder<QuerySnapshot>(
                      stream: orderDoc.reference
                          .collection('orderItems')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> subCollectionSnapshot) {
                        if (subCollectionSnapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (subCollectionSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading');
                        }
                        /// We create List<Widget> itemsList which is a list of
                        /// all the items in the order so that they can be
                        /// displayed on the screen. We choose the display format:
                        /// QUANTITY x NAME
                        ///     at PRICE each.
                        List<Widget> itemsList = subCollectionSnapshot
                            .data!.docs
                            .map((doc) => Text(
                                "${doc['quantity']} x ${doc['title']}\n\t\t\tat \$${doc['price']} each",
                                style: const TextStyle(fontSize: 18)))
                            .toList();
                        /// Get the total price of the order.
                        var totalPrice =
                            _totalPrice(subCollectionSnapshot.data!.docs);
                        /// Get the total price of the order with tip to help out
                        /// our drivers.
                        var totalPriceWithTip = _totalPriceWithTip(totalPrice);

                        /// The details of the order are displayed vertically.
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// We display the information in Text()s with
                            /// spacing in between. Larger spacing between "sections"
                            /// and smaller spacing between "section title" and
                            /// "section content".
                            /// Display the orderNumber
                            Text("Order Number:   $orderNumber",
                                style: const TextStyle(fontSize: 18)),
                            /// Use a larger spacing between "sections"
                            const SizedBox(height: 16),
                            /// Display the address
                            const Text("Address:",
                                style: TextStyle(fontSize: 18)),
                            /// Use a smaller spacing between title and content.
                            const SizedBox(height: 8),
                            /// Display the address content.
                            Text("$streetAddress\n$cityAddress",
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 16),
                            const Text("Items: ",
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            /// Use a Column() to display the list of items vertically.
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: itemsList),
                            const SizedBox(height: 16),
                            const Text("Total:",
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text("\$$totalPrice (tax included)",
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text("\$$totalPriceWithTip (with tip)",
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 32),
                            /// Create a big button for the driver to confirm
                            /// that the order has been delivered. Change bool
                            /// isDelivered to true and String status to 'Delivered'
                            /// in the database at the same time.
                            ElevatedButton(
                                onPressed: () {
                                  snapshot.data!.docs.first.reference.update({
                                    'isDelivered': true,
                                    'status': 'Delivered'
                                  });
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(30.0))),
                                child: const Text("Order Delivered",
                                    style: TextStyle(fontSize: 24)))
                          ],
                        );
                        // }
                      });
                }
              })
        ])),
        /// We use the driver's bottom navbar.
        bottomNavigationBar: const DriverBottomNavigationBar(),
      ),
    );
  }
}
