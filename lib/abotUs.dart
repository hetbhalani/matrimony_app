import 'package:aswdc_flutter_pub/aswdc_flutter_pub.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/user.dart';

import 'UserList.dart';
import 'favUser.dart';
int _selectedIndex = 3;

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DeveloperScreen(
        developerName: 'Het Bhalani',
        mentorName: 'Prof. Mehul Bhundiya',
        exploredByName: 'ASWDC',
        isAdmissionApp: true,
        isDBUpdate: true,
        shareMessage: '',
        appTitle: 'JanmoKeSathi',
        appLogo: 'assets/imgs/logo.png',
        colorValue: Color.fromRGBO(255, 34, 34, 0.8),
        appBarColor: Color.fromRGBO(255, 34, 34, 0.8),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [

                GButton(
                  icon: Icons.add_box_outlined,
                  text: 'Add User',
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CrudUser()));
                  },
                ),
                GButton(
                  icon: Icons.list_alt_rounded,
                  text: 'User List',
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Userlist()));
                  },
                ),
                GButton(
                  icon: Icons.favorite_border_rounded,
                  text: 'Favorite',
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FavUsers()));
                  },
                ),
                GButton(
                  icon: Icons.school_outlined,
                  text: 'About Us',
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AboutUs()));
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
