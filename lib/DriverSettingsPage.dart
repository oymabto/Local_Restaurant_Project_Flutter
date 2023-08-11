/// Done by Alireza

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_final_project/DriverBottomNavigationBar.dart';
import 'main.dart';

/// This class DriverSettingsPage is a StatelessWidget that is the About Us
/// screen. We display all the information here in a Stack(). We show images,
/// and text. It is a static information page for the driver's.
class DriverSettingsPage extends StatelessWidget {
  const DriverSettingsPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    String driverId = Provider.of<EmployeeInfo>(context).id;
    String driverName = Provider.of<EmployeeInfo>(context).name;
    String driverFamily = Provider.of<EmployeeInfo>(context).family;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, 'DriverDashboard');
          return false;
        },
    child: Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("About Us"),

            /// This Text widget will display the driver's name and family name.
            Text("$driverName $driverFamily", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                    'https://i.postimg.cc/9XkL1tb9/louis-hansel-0s-YLBZjg-TTw-unsplash.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Center(
                //   child: Text(
                //     'About Us',
                //     style: TextStyle(
                //       fontSize: 24.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10.0),
                const Text(
                  'Welcome to Bytes on Bikes, a family-owned kitchen delivering exceptional cuisine with an eco-friendly twist. Located in downtown Montreal, we proudly serve within a 5 km radius, blending our computer science background with our culinary passion. By choosing bikes for delivery, we reduce our environmental impact while adding a personal touch to each order.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'At Bytes on Bikes, we believe in the power of food to forge connections and create lasting memories. As a family business, we warmly welcome you as part of our extended family. Our thoughtfully curated menu features a diverse array of dishes, prepared with love and meticulous attention to detail. Whether you crave comforting classics or bold innovations, our skilled chefs are dedicated to satisfying your palate.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20.0),
                Image.network(
                  'https://i.postimg.cc/nhjT6sdW/sagar-rana-b-FDdb5-Yl-w-unsplash.jpg',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Your Support',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'By supporting Bytes on Bikes, you\'re not only treating yourself to exquisite cuisine, but also supporting a local, community-driven establishment. Our friendly delivery drivers, pedaling through the city on their bikes, ensure that your orders arrive promptly and with a personal touch. Join our welcoming community, savor the flavors of Bytes on Bikes, and let us be part of your culinary journey.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const DriverBottomNavigationBar(),
    ),
    );
  }
}