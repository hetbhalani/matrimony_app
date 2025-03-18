import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/loginScreen.dart';
import 'package:matrimonial_app/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserList.dart';
import 'abotUs.dart';
import 'favUser.dart';

class Pageviewbuilder extends StatefulWidget {
  final int initialIndex;
  const Pageviewbuilder({super.key, required this.initialIndex});

  @override
  State<Pageviewbuilder> createState() => _PageviewbuilderState();
}

class _PageviewbuilderState extends State<Pageviewbuilder> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    CrudUser(),
    Userlist(),
    FavUsers(),
    AboutUs(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _logout() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove("email");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/imgs/logo.png',
              height: 35,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text(
              "JanmoKeSathi",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),

          ],
        ),
        backgroundColor: const Color(0xff69247C),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 34, 34, 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "User Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 22,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.add_box_outlined,
                  text: 'Add User',
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                GButton(
                  icon: Icons.list_alt_rounded,
                  text: 'User List',
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                GButton(
                  icon: Icons.favorite_border_rounded,
                  text: 'Favorite',
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                GButton(
                  icon: Icons.school_outlined,
                  text: 'About Us',
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
