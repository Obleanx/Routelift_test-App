import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bowlFood, // Replace with the desired font icon
                size: 24.0,
              ),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          selectedFontSize: 16.0,
          unselectedFontSize: 12.0,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
