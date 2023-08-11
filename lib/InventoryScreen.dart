/// Done by Alireza

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CreateInventoryItemForm.dart';
import 'CustomBottomNavigationBar.dart';
import 'InventoryCard.dart';
import 'InventoryGridView.dart';
import 'main.dart';

/// The InventoryScreen class creates a screen that displays the inventory items and lets managers manage them.
/// It shows all the items stored in the Firestore database.
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// We get the manager's name and family name from the Provider.
    /// Provider is a tool that lets us easily share data between different parts of the app.
    String managerName = Provider.of<EmployeeInfo>(context).name;
    String managerFamily = Provider.of<EmployeeInfo>(context).family;
    return Scaffold(
      appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Inventory Management"),

              /// This Text widget will display the manager's name and family name.
              Text("$managerName $managerFamily", style: const TextStyle(fontSize: 16)),
            ],
          ),
        actions: [

          /// Add a button to the AppBar that lets the manager create a new item.
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {

              /// When the button is pressed, open the CreateInventoryItemForm screen.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateInventoryItemForm()));
            },
          ),
        ],
      ),
      // body: StreamBuilder<QuerySnapshot>(
      body: SingleChildScrollView(

        /// StreamBuilder listens to changes in the Firestore database and automatically updates the screen when data changes.
        child: StreamBuilder<QuerySnapshot>(

          /// We tell it to listen to the 'inventory' collection in the Firestore database.
          stream:
              FirebaseFirestore.instance.collection('inventory').snapshots(),

          /// The builder makes the visual part of the screen.
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            List<dynamic> inventoryItems = snapshot.data!.docs;
            return InventoryGridView(inventoryItems: inventoryItems);
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        isLoggedIn: true, // Set based on your authentication status
        currentIndex: -1, // Pass -1 to not highlight any tab
        onTabSelected: (index) {
          // Define what should happen when a tab is selected
        },
      ),
    );
  }
}
