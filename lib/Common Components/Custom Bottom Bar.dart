

import 'package:flutter/material.dart';
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      shape: const CircularNotchedRectangle(),
      color: const Color(0xFF1C8C70),  // Custom green color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => onItemTapped(0),
            color: selectedIndex == 0 ? Colors.white : Colors.white70,
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble),
            onPressed: () => onItemTapped(1),
            color: selectedIndex == 1 ? Colors.white : Colors.white70,
          ),
          const SizedBox(width: 40), // Space for the centered + button
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => onItemTapped(2),
            color: selectedIndex == 2 ? Colors.white : Colors.white70,
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => onItemTapped(3),
            color: selectedIndex == 3 ? Colors.white : Colors.white70,
          ),
        ],
      ),
    );
  }
}
