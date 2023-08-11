/// Done by Alireza

import 'package:flutter/material.dart';
import 'MenuCard.dart';


/// MenuGridView is a widget that displays a grid of menu items.
/// It takes a list of menu items and uses the GridView.builder to create a grid.
/// Each grid item is represented by a MenuCard.
class MenuGridView extends StatelessWidget {
  final List<dynamic> menu;

  const MenuGridView({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      /// shrinkWrap makes the grid take the minimum space required.
      shrinkWrap: true,

      /// NeverScrollableScrollPhysics means this grid will not scroll.
      /// This can be useful when you want the surrounding widget to control the scrolling.
      physics: const NeverScrollableScrollPhysics(),

      /// gridDelegate controls how the grid items are displayed.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: menu.length,
      itemBuilder: (context, index) {
        return SizedBox(

          /// Using MenuCard to represent each item and passing the corresponding menu data to it.
          child: MenuCard(menuData: menu[index]),
        );
      },
    );
  }
}
