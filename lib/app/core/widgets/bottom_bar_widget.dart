import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  final void Function(int)? tap;
  final int selectedIndex;
  final List<BottomNavigationBarItem> items;

  const BottomBarWidget(
      {super.key, this.tap, required this.selectedIndex, required this.items});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blueAccent,
      currentIndex: selectedIndex,
      items: items,
      onTap: tap,
    );
  }
}
