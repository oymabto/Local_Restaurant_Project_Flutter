/// Done by Alireza

import 'package:flutter/material.dart';

class ManagerDashboardBasicCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onClick;

  const ManagerDashboardBasicCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 200,
      child: Card(
        child: InkWell(
          onTap: onClick,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  imageUrl,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
