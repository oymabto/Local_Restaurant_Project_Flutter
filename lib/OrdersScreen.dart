/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'CustomBottomNavigationBar.dart';
import 'OrdersListView.dart';
import 'main.dart';

/// OrdersScreen class is responsible for displaying a screen where the manager can see all the orders. It is a simple screen with a list of order cards..
/// Each card contains information about an individual order. It retrieves data from the Firestore database and displays it in a list.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// It is specifying that it wants to retrieve an object of type EmployeeInfo.
    /// The <EmployeeInfo> is a type parameter that tells Provider what type of object we are trying to obtain.
    /// (context) is passing the BuildContext called context to the of method.
    /// This is necessary because the Provider uses the context to determine where in the widget tree it needs to look for the requested object.
    /// This line is used for obtaining the name property of an EmployeeInfo object that is available higher up in the widget tree (main.dart), and assigning this name to the variable managerName.
    String managerName = Provider.of<EmployeeInfo>(context).name;
    String managerFamily = Provider.of<EmployeeInfo>(context).family;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Order Management"),

            /// This Text widget will display the manager's name and family name.
            Text("$managerName $managerFamily", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(

        /// Connecting to Firestore and listening to a stream of data from the 'orders' collection.
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          List<dynamic> orders = snapshot.data!.docs;
          print("The list of orders:"+'$orders');
          return OrdersListView(orders: orders);
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        isLoggedIn: true,

        /// Set 'currentIndex' to 1 to highlight the 'Orders' tab.
        currentIndex: 1,
        onTabSelected: (index) {
        },
      ),
    );
  }
}
