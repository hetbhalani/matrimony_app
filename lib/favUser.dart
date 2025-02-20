import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/user.dart';
import 'package:matrimonial_app/userList.dart';
import 'package:matrimonial_app/home.dart';
import 'package:matrimonial_app/db.dart';

import 'abotUs.dart';

List<Map<String, dynamic>> FavUser = [];  // Used for storing the favorite users

class FavUsers extends StatefulWidget {
  const FavUsers({super.key});

  @override
  State<FavUsers> createState() => _FavUsersState();
}

List<Map<String, dynamic>> favUsers = [];

class _FavUsersState extends State<FavUsers> {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    loadFavUsers();
  }

  Future<void> loadFavUsers() async {
    await MatrimonyDB().fetchUsers();
    fetchFavUsers();
  }

  Future<void> fetchFavUsers() async {
    // Fetch the favorite users from the database
    List<Map<String, dynamic>> data = await MatrimonyDB().getFavUsers();
    // Update the state with the fetched favorite users
    setState(() {
      favUsers = data;
    });
  }

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
            child: favUsers.isNotEmpty
                ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favUsers.length,
              itemBuilder: (context, index) {
                return _buildFavUserCard(index);
              },
            )
                : Center(
              child: Text(
                "Koi Pasand Nathi!",
                style: TextStyle(fontSize: 20, color: Colors.grey),
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
                      favUsers[index]['gender'] == 'Male'
                          ? 'assets/imgs/male.png'
                          : 'assets/imgs/female.png',
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${favUsers[index]['name']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                _buildUserInfo("City:", favUsers[index]['city']),
                _buildUserInfo("Phone:", favUsers[index]['phone']),
                _buildUserInfo("Gender:", favUsers[index]['gender']),
              ],
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_rounded, color: Colors.pinkAccent),
                  iconSize: 25,
                  onPressed: () async {
                    int userId = favUsers[index]['id'];
                    int newFav = favUsers[index]['isFav'] == 1 ? 0 : 1;
                    await MatrimonyDB().updateUser(id: userId, isFav: newFav);
                    fetchFavUsers();
                    print("Hello");
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
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutUs()));
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
