import 'package:flutter/material.dart';
import 'package:matrimonial_app/PageViewBuilder.dart';
import 'package:matrimonial_app/UserList.dart';
import 'package:matrimonial_app/abotUs.dart';
import 'package:matrimonial_app/favUser.dart';
import 'package:matrimonial_app/loginScreen.dart';
import 'dart:ui';

import 'package:matrimonial_app/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildBlurredButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Color.fromRGBO(250, 198, 122, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          child: child,
        ),
      ),
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
              // alignment: Alignment.topLeft,
            ),
            SizedBox(
              width: 10,
            ),
            const Text(
              "JanmoKeSathi",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                var pref = await SharedPreferences.getInstance();
                await pref.remove("email");
                print("Logout");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.logout, color: Colors.white, size: 25),
            )
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 34, 34, 0.8),
      ),
      body: Container(
        color: Color.fromRGBO(249, 230, 207, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBlurredButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Pageviewbuilder(initialIndex: 0)),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/imgs/add.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Add User',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  _buildBlurredButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Pageviewbuilder(initialIndex: 1)),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/imgs/UserList.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'User List',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBlurredButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Pageviewbuilder(initialIndex: 2)),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/imgs/Fav.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Favorites',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  _buildBlurredButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Pageviewbuilder(initialIndex: 3)),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/imgs/about-us.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
