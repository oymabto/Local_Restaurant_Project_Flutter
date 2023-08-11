/// Devin Oxman

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DriverManagementCard.dart';
import 'DriverManagementEditDialogue.dart';
import 'DriverData.dart';
import 'main.dart';

/// This class generates a list of all drivers
class DriverManagementListDrivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('drivers').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              //convert list of database documents to a list of DriverData objects
              List<DriverData> listOfDrivers = snapshot.data!.docs.map((doc) => DriverData(
                  id: doc['id'],
                  name: doc['name'],
                  family: doc['family'],
                  email: doc['email'],
                  username: doc['username'],
                  password: doc['password'],
                  imageUrl: doc['imageUrl'],
                  availability: doc['availability']
              )).toList();
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: listOfDrivers.length,
                  itemBuilder: (context, index) {
                    /// Calls a card for each driver, passes in the DriverData object for display, and the snapshot reference for editing and deletion
                    return DriverManagementCard(driver: listOfDrivers[index], driverData: snapshot.data!.docs[index]);
                  });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          /// Calls the EditDriverDialogue widget with the isNew boolean set to true to add a button to add a new driver
          child: EditDriverDialogue(isNew: true, parentContext: context),
        ),
      ],
    );
  }
}