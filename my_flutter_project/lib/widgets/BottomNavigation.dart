import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  int currIndex = 0;
  BottomNavigation({required this.currIndex});

  void changePage(int i, BuildContext ctx) {
    if (i == 0) {
      currIndex = i;
      Navigator.of(ctx).pushReplacementNamed('/homepage');
    }
    if (i == 1) {
      currIndex = i;
      Navigator.of(ctx).pushReplacementNamed('/coinSummary');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      onTap: (value) => changePage(value, context),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.paid), label: "Neu-coins"),
      ],
      selectedItemColor: Colors.amber[800],
      //onTap: _onItemTapped,
    );
  }
}
