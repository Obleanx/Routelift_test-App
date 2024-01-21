import 'package:flutter/material.dart';

class NavigationBarDesigns extends StatelessWidget {
  const NavigationBarDesigns({Key? key}) : super(key: key);

  static const SideNavbarTextStyle = TextStyle(
    color: Color(0xffd1d4d7),
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const UserNavbarTextStyle = TextStyle(
    color: Color(0xff358600),
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Drawer positioned on the left
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Drawer(
              child: Container(
                color: const Color(0xff1c1c1c),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: const Text(
                        'John Doe',
                        style: UserNavbarTextStyle,
                      ),
                      accountEmail: const Text(
                        'example@gmail.com',
                        style: UserNavbarTextStyle,
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: Image.asset(
                            'lib/images/bg.jpeg',
                            width: 200,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xffb9d4db),
                        image: DecorationImage(
                          image: AssetImage('lib/images/bike.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Design 1', style: SideNavbarTextStyle),
                      onTap: () {
                        // Handle onTap for Design 1
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Design 2', style: SideNavbarTextStyle),
                      onTap: () {
                        // Handle onTap for Design 2
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Design 2', style: SideNavbarTextStyle),
                      onTap: () {
                        // Handle onTap for Design 2
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Design 2', style: SideNavbarTextStyle),
                      onTap: () {
                        // Handle onTap for Design 2
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Design 2', style: SideNavbarTextStyle),
                      onTap: () {
                        // Handle onTap for Design 2
                        Navigator.pop(context);
                      },
                    ),
                    // Add more designs as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
