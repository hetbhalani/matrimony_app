import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/user.dart';
import 'package:matrimonial_app/userList.dart';
import 'package:matrimonial_app/home.dart';

import 'abotUs.dart';

List<Map<String, dynamic>> FavUser = [];

class FavUsers extends StatefulWidget {
  const FavUsers({super.key});

  @override
  State<FavUsers> createState() => _FavUsersState();
}

class _FavUsersState extends State<FavUsers> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/imgs/logo.png',
              height: 35,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 10,
            ),
            const Text(
              "JanmoKeSathi",
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 48, 48, 0.8),
      ),

      body: Column(
        children: [
          SizedBox(height: 10), // Optional top spacing

          Expanded(
            child: FavUser.isNotEmpty ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: FavUser.length,
              itemBuilder: (context, index) {
                return _buildFavUserCard(index);
              },
            ) : Center(
              child: Text(
                "Koi Pasand Nathi!",
                style: TextStyle(fontSize: 20,color: Colors.grey),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildFavUserCard(int index) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      FavUser[index]['gender']
                          ? 'assets/imgs/male.png'
                          : 'assets/imgs/female.png',
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${FavUser[index]['name']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                _buildUserInfo("City:", FavUser[index]['city']),
                _buildUserInfo("Phone:", FavUser[index]['phone']),
                // _buildUserInfo("Email:", FavUser[index]['email']),
                _buildUserInfo("Gender:", FavUser[index]['gender'] ? 'Male' : 'Female',),
              ],
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_rounded, color: Colors.pinkAccent),
                  iconSize: 25,
                  onPressed: () {
                    setState(() {
                      users[users.indexOf(FavUser[index])]['isFav'] =
                      !users[users.indexOf(FavUser[index])]['isFav'];
                      FavUser.removeAt(index);
                    });
                  },
                ),
                // SizedBox(height: 40),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  iconSize: 25,
                  onPressed: () => print("Edit button pressed"),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  iconSize: 25,
                  onPressed: () {
                    setState(() {
                      users.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 0, 0),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CrudUser()));
                },
              ),
              GButton(
                icon: Icons.list_alt_rounded,
                text: 'User List',
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Userlist()));
                },
              ),
              GButton(
                icon: Icons.favorite_border_rounded,
                text: 'Favorite',
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FavUsers()));
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
    );
  }
}
