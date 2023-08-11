/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'CustomBottomNavigationBar.dart';
import 'MenuCard.dart';
import 'MenuGridView.dart';
import 'main.dart';

/// MenuScreen class displays a screen where you can manage the menu items.
/// It shows a list of menu items fetched from a Firestore database.
/// It also displays the manager's name and family in the app bar.
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String managerName = Provider.of<EmployeeInfo>(context).name;
    String managerFamily = Provider.of<EmployeeInfo>(context).family;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Menu Management"),

            /// This Text widget will display the manager's name and family name.
            Text("$managerName $managerFamily", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(

          /// We're setting up a stream to the Firestore database to get real-time updates of the menu collection.
          stream: FirebaseFirestore.instance.collection('menu').snapshots(),

          /// The builder is called every time the data in the stream changes.
          /// It's responsible for building the UI with the latest data.
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            /// Once the data is loaded, store it in a list.
            List<dynamic> menu = snapshot.data!.docs;

            /// Pass the menu data to MenuGridView to display it in a grid format.
            return MenuGridView(menu: menu);
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        isLoggedIn: true,
        currentIndex: -1,
        onTabSelected: (index) {
        },
      ),
    );
  }
}
