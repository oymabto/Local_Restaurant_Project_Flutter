/// Devin Oxman

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/DriverManagementEditDialogue.dart';
import 'DriverData.dart';
import 'main.dart';

/// This widget renders the driver information for the list of drivers in the manager screen
/// It also hosts the edit and delete buttons for driver crud
class DriverManagementCard extends StatelessWidget {

/// Instanciate a snapshot to conect to the firebase collection
  final DocumentSnapshot driverData;
  final DriverData driver;

  /// DriverData driver;
  /// Checks if an image url has been set for the driver
  /// Used in the widget to skip presenting the driver image if an image is not available
  /// Will return true if there is a image url in the driver object
  bool _imageUrlIsNotEmpty() {
    return driver.imageUrl != '';
  }

  const DriverManagementCard(
      {Key? key, required this.driver, required this.driverData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool availability = driver.availability;

    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// Make sure the driver has an associated image to render, otherwise skip the image child
            if (_imageUrlIsNotEmpty())
              Image.network(
                driver.imageUrl,
                width: 120,
                height: 120,
              ),
            Text(
              "${driver.family} ${driver.name}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Available",
                        style: Theme.of(context).textTheme.bodyMedium),
                    /// Provides a toggle to make a driver available or not
                    Switch(
                      value: availability,
                      /// It uses menuData.reference to get a reference to the document in Firestore that corresponds to the menu item, and then calls the update method with the new availability value.
                      /// This essentially syncs the state of the Switch with the data in Firestore.
                      onChanged: (value) {
                        availability = value;
                        driverData.reference.update({'availability': value});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// This uses the DriverManagementEditDialogue class to render an edit button
                    EditDriverDialogue(
                        driverData: driverData,
                        isNew: false,
                        parentContext: context),
                    /// This uses the database to remove the current driver from the drivers collection
                    TextButton(
                      child: Text('Delete'),
                      onPressed: () {
                        driverData.reference.delete();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}