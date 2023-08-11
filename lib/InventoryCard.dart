/// Done by Alireza

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This class is meant to display an InventoryCard widget on the screen
/// It will be used by the Inventory class to fill the InventoryScreen with content.
/// DocumentSnapshots are used to talk to and exchange data with the Firestore database where the inventory information is stored.
class InventoryCard extends StatelessWidget{

  /// We're setting up inventoryData, which is a DocumentSnapshot that helps us interact with the database.
  /// DocumentSnapshot is like a snapshot of a single item in the database, and it automatically refreshes whenever the database changes.
  /// By giving this snapshot to InventoryCard, we're providing the card with the information it needs to show on the screen.
  final DocumentSnapshot inventoryData;

  const InventoryCard({
    Key? key, required this.inventoryData
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {

    /// The Card widget makes our inventory item look like a card on the screen.
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(4.0),
      // child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                inventoryData['name'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  inventoryData['imageUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Quantity: ${inventoryData['quantity']}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              /// This row has two buttons to change the quantity.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      inventoryData.reference.update({'quantity': inventoryData['quantity'] - 1});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      inventoryData.reference.update({'quantity': inventoryData['quantity'] + 1});
                    },
                  ),
                ],
              ),

              /// This button deletes the item.
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  inventoryData.reference.delete();
                },
              ),
            ],
          ),
        // ),
      ),
    );
  }
}