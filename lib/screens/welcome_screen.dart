import 'package:flutter/material.dart';
import 'package:routelift_app/screens/home_screen.dart';

class WelcomePage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePage(context),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'lib/images/bg.jpeg',
          fit: BoxFit.cover,
        ),
        const Positioned(
          top: 100,
          left: 25,
          child: Text(
            "Explore culinary\ntraditions in every\ndish you order.",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Color(0xff358600),
            ),
          ),
        ),
        Positioned(
          bottom: 140,
          left: 36,
          child: ElevatedButton(
            onPressed: () {
              // it Navigates to ProductListPage when the button is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Adjust text color as needed
            ),
            child: const Text('Get Started'),
          ),
        ),
      ],
    );
  }
}
