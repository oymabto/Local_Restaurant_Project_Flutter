/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class MenuCard extends StatelessWidget {

  /// DocumentSnapshot is a class provided by the Firestore package.
  /// A DocumentSnapshot represents a single document from a Firestore database.
  /// It contains data and metadata for the document.
  /// In Firestore, data is stored in collections, and each individual piece of data in a collection is a document.
  /// The DocumentSnapshot allows you to work with the contents of a document programmatically.
  final DocumentSnapshot menuData;

  const MenuCard({
    Key? key,
    required this.menuData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool availability = menuData['availability'];

    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300.0, // Set a maximum height for the card
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  menuData['imageUrl'],
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 8.0),
                Text(
                  menuData['title'],
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Price: \$${menuData['price']}",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Preparation Time: ${menuData['preparationTime']} mins",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Available",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Switch(
                      value: availability,

                      /// It uses menuData.reference to get a reference to the document in Firestore that corresponds to the menu item, and then calls the update method with the new availability value.
                      /// This essentially syncs the state of the Switch with the data in Firestore.
                      onChanged: (value) {
                        availability = value;
                        menuData.reference.update({'availability': value});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
