import 'package:flutter/material.dart';

class HomeDesktop extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onLogout;
  final Widget body;

  const HomeDesktop({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    required this.onLogout,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: selectedIndex,
          onDestinationSelected: onTabChanged,
          labelType: NavigationRailLabelType.all,
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                // ВИПРАВЛЕНО: замінено .amend на .only
                padding: const EdgeInsets.only(bottom: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  tooltip: 'Вийти з аккаунта',
                  onPressed: onLogout,
                ),
              ),
            ),
          ),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.monitor),
              selectedIcon: Icon(Icons.monitor, color: Colors.blue),
              label: Text('Монітор'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.gradient),
              selectedIcon: Icon(Icons.gradient, color: Colors.blue),
              label: Text('Котушки'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: body),
      ],
    );
  }
}