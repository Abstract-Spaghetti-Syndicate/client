import 'package:flutter/material.dart';

class HomeMobile extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final Widget body;

  const HomeMobile({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor),
            label: 'Монітор',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gradient),
            label: 'Котушки',
          ),
        ],
      ),
    );
  }
}