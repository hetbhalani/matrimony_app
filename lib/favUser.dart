import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/crudAPI.dart';
import 'package:matrimonial_app/user.dart';
import 'package:matrimonial_app/userList.dart';
import 'package:matrimonial_app/home.dart';
import 'abotUs.dart';

List<Map<String, dynamic>> favUsers = [];

class FavUsers extends StatefulWidget {
  const FavUsers({super.key});

  @override
  State<FavUsers> createState() => _FavUsersState();
}

class _FavUsersState extends State<FavUsers> {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    loadFavUsers();
  }

  Future<void> loadFavUsers() async {
    await fetchFavUsers();
  }

  Future<void> fetchFavUsers() async {
    List<Map<String, dynamic>> data = await API_Users().getFavouriteUsers();
    setState(() {
      favUsers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f0ff),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: favUsers.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: favUsers.length,
                    itemBuilder: (context, index) {
                      return _buildFavUserCard(index);
                    },
                  )
                : const Center(
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
                    const SizedBox(width: 10),
                    Text(
                      "${favUsers[index]['name']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                _buildUserInfo("City:", favUsers[index]['city']),
                _buildUserInfo("Phone:", favUsers[index]['phone']),
                _buildUserInfo("Gender:", favUsers[index]['gender']),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_rounded,
                      color: Colors.pinkAccent),
                  iconSize: 25,
                  onPressed: () async {
                    int currentFav = favUsers[index]['isFav'] is int
                        ? favUsers[index]['isFav']
                        : int.tryParse(
                                favUsers[index]['isFav'].toString()) ??
                            0;
                    int newFav = currentFav == 1 ? 0 : 1;
                    await API_Users().updateUser(
                      {'isFav': newFav},
                      favUsers[index]['id'].toString(),
                    );
                    fetchFavUsers();
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
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
