/// Done by Alireza

import 'package:flutter/material.dart';
import 'OrdersScreen.dart';
import 'ManagerDashboard.dart';
import 'ContactUsScreen.dart'; // Import SettingScreen here

/// This CustomBottomNavigationBar class is a custom widget that provides a navigation bar at the bottom of the app's screen.
/// The Home button takes the user to the ManagerDashboard screen,
/// the Orders button takes them to the OrdersScreen, and the Contact Us button takes them to the ContactUsScreen.
/// The buttons light up when selected and the color changes to show you are on that page.
/// If a user is not logged in, the buttons won’t work to prevent unauthorized access.
class CustomBottomNavigationBar extends StatelessWidget {
  final bool isLoggedIn;
  final Function(int) onTabSelected;
  final int currentIndex;

  /// isLoggedIn keeps track if the user has logged in or not.
  /// onTabSelected is a function we can use to do something when a tab is clicked.
  /// currentIndex tells us which tab is currently selected.
  const CustomBottomNavigationBar({
    Key? key,
    required this.isLoggedIn,
    required this.onTabSelected,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.contact_page),
        label: 'Contact Us',
      ),
    ];

    return BottomNavigationBar(

      /// This makes sure the selected button is highlighted unless the index is out of bounds.
    currentIndex: (currentIndex >= 0 && currentIndex < items.length) ? currentIndex : 0,

      /// This is where we actually give the navigation bar the buttons we created earlier.
      items: items,

      /// This code runs when we tap one of the buttons.
      onTap: (index) {

        /// If the user is not logged in, don't do anything.
        if (!isLoggedIn) {
          return;
        }
        onTabSelected(index);
        switch (index) {
          case 0: // Home
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ManagerDashboard(managerName: "Your Manager Name Here"))); // You need to pass managerName to ManagerDashboard
            break;
          case 1: // Orders
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => OrdersScreen()));
            break;
          case 2: // Settings
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ContactUsScreen())); // Make sure SettingScreen is defined
            break;
        }
      },

      /// Make the selected button's text match the app's main color, unless the index is out of bounds, then make it grey.
      selectedItemColor: (currentIndex >= 0 && currentIndex < items.length) ? Theme.of(context).primaryColor : Colors.grey,
    );
  }
}
