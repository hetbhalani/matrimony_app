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
    List<Map<String, dynamic>> data = await MatrimonyDB().getFavUsers();
    setState(() {
      favUsers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f0ff),
      body: Column(
        children: [
          SizedBox(height: 10),
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

}
