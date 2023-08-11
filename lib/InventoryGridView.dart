/// Done by Alireza

import 'package:flutter/material.dart';
import 'InventoryCard.dart';

class InventoryGridView extends StatelessWidget {
  final List<dynamic> inventoryItems;

  const InventoryGridView({Key? key, required this.inventoryItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: InventoryCard(inventoryData: inventoryItems[index]),
        );
      },
    );
  }
}
