/// Done by Alireza

import 'package:flutter/material.dart';

import 'CustomBottomNavigationBar.dart';

/// This ContactUsScreen class is a custom widget that shows the 'Contact Us' page of the app.
/// The page has a background image with some darkening, and on top of that, it displays contact information.
/// It tells you about the employees, the location, phone number, email, and when the place was established.
/// At the bottom, it has links to social media. It also has a bottom navigation bar so you can go to other sections of the app.
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bytes on Bikes"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                    "https://i.postimg.cc/qMdMdJY1/michal-biernat-h0x-EUQXz-U38-unsplash.jpg"),

                /// This makes sure the image covers the whole background.
                fit: BoxFit.cover,

                /// A dark filter on the image so text is easier to read.
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                contactInfo(
                    icon: Icons.person,
                    title: "Employees",
                    info: "Alireza, Devin, Harsha, Ian, and Calvert"),
                contactInfo(
                    icon: Icons.location_on,
                    title: "Location",
                    info: "1337 Coolguys Ave., Montreal QC"),
                contactInfo(
                    icon: Icons.phone,
                    title: "Telephone",
                    info: "(514)-999-9910"),
                contactInfo(
                    icon: Icons.email,
                    title: "E-Mail",
                    info: "bytesonbikes@winning.com"),
                contactInfo(
                    icon: Icons.edit,
                    title: "Established",
                    info: "2023 March 28"),
                const SizedBox(height: 40),
                const Text(
                  "Operating Hours:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Mon - Fri:   9am - 11pm\nSat: 10am - 10pm\nSun: Closed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    socialMediaLink(
                        imageUrl:
                            "https://i.postimg.cc/V5S3CbZx/facebook-color-svgrepo-com.png",
                        title: "Facebook"),
                    socialMediaLink(
                        imageUrl:
                            "https://i.postimg.cc/HcNRNpnv/twitter-svgrepo-com.png",
                        title: "Twitter"),
                    socialMediaLink(
                        imageUrl:
                            "https://i.postimg.cc/MfjN2hj6/instagram-167-svgrepo-com.png",
                        title: "Instagram"),
                    socialMediaLink(
                        imageUrl:
                            "https://i.postimg.cc/NLWZ7fW5/pinterest-180-svgrepo-com.png",
                        title: "Pinterest"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        isLoggedIn: true,

        /// Set 'currentIndex' to 1 to highlight the 'Orders' tab.
        currentIndex: 2,
        onTabSelected: (index) {},
      ),
    );
  }
  /// This method helps in creating the contact info lines.
  Widget contactInfo(
      {required IconData icon, required String title, required String info}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [

          /// The icon next to the info.
          Icon(icon, color: Colors.white),

          /// A little gap between icon and text.
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// The title (like "Location").
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),

              /// The actual information.
              Text(info, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
  /// This method helps in creating social media link icons.
  Widget socialMediaLink({required String imageUrl, required String title}) {
    return Column(
      children: [

        /// The social media icon.
        Image.network(imageUrl, height: 32, width: 32),

        /// A little gap between the icon and its label.
        const SizedBox(height: 4),

        /// The label (like "Facebook").
        Text(title),
      ],
    );
  }
}
