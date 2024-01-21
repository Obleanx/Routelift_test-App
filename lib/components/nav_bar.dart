// top_navigation_bar.dart

import 'package:flutter/material.dart';
import 'package:routelift_app/components/navbar_designs.dart';

class TopNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // Handle onTap for the top left navigation bar
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationBarDesigns()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: Image.asset('lib/images/navbar.jpeg'),
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('lib/images/bg.jpeg'),
          ),
        ),
      ],
    );
  }
}
