/// Done by Ian

import 'package:flutter/material.dart';

/// From Alireza's code and source: https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
/// This class DriverBottomNavigationBar is a StatefulWidget that is the driver's
/// bottom navbar. It is stateful so that the selected item will change colour.
/// We can navigate to the Driver Dashboard, the Current Delivery Page, and the
/// About Us page.
class DriverBottomNavigationBar extends StatefulWidget {
  const DriverBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<DriverBottomNavigationBar> createState() => _DriverBottomNavigationBarState();
}

class _DriverBottomNavigationBarState extends State<DriverBottomNavigationBar> {
  /// Start at the first navbar tab.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// This function _handleTabSelected takes an int index which is the selected
    /// tab in the navbar. We set the state according to the tab selected, and
    /// use named pushes to navigate to other screens in the app that are for the
    /// logged in driver.
    void _handleTabSelected(int index) {
      /// Set the state to the index.
      setState(() {
        _selectedIndex = index;
      });
      /// If the index is 0, 1, or 2, push the correct screen.
      if (index == 0) {
        Navigator.pushReplacementNamed(context, 'DriverDashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, 'CurrentDelivery');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, 'DriverSettings');
      }
    }

    /// We return this navbar, and we select which tab is which with a list of
    /// BottomNavigationBarItem()s.
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        /// The Home page (Driver Dashboard)
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        /// Current Delivery page
        BottomNavigationBarItem(
            icon: Icon(Icons.bike_scooter), label: 'Current Delivery'),
        /// About Us page.
        BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'About Us')
      ],
      /// Set the current index to the selected index.
      currentIndex: _selectedIndex,
      /// Use onTap and pass the index selected.
      onTap: (index) {
        _handleTabSelected(index);
      },
    );
  }
}
