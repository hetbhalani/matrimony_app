import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/crudAPI.dart';
import 'package:matrimonial_app/user.dart';
import 'package:matrimonial_app/userList.dart';
import 'package:matrimonial_app/home.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'abotUs.dart';

List<Map<String, dynamic>> favUsers = [];

class FavUsers extends StatefulWidget {
  const FavUsers({super.key});

  @override
  State<FavUsers> createState() => _FavUsersState();
}

class _FavUsersState extends State<FavUsers> {
  int _selectedIndex = 2;
  bool _isLoading = true;  // Add loading state

  @override
  void initState() {
    super.initState();
    loadFavUsers();
  }

  Future<void> loadFavUsers() async {
    setState(() => _isLoading = true);
    try {
      await fetchFavUsers();
    } finally {
      setState(() => _isLoading = false);
    }
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
            child: Skeletonizer(
              enabled: _isLoading,
              child: favUsers.isEmpty && !_isLoading
                  ? const Center(
                      child: Text(
                        "Koi Pasand Nathi!",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: _isLoading ? 5 : favUsers.length, // Show 5 skeleton items while loading
                      itemBuilder: (context, index) {
                        final user = _isLoading
                            ? {
                                'name': 'John Doe',
                                'city': 'New York',
                                'phone': '1234567890',
                                'gender': 'Male',
                                'isFav': 1,
                              }
                            : favUsers[index];
                        return _buildFavUserCard(index, user);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavUserCard(int index, Map<String, dynamic> user) {
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
                      user['gender'] == 'Male'
                          ? 'assets/imgs/male.png'
                          : 'assets/imgs/female.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${user['name']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                _buildUserInfo("City:", user['city']),
                _buildUserInfo("Phone:", user['phone']),
                _buildUserInfo("Gender:", user['gender']),
              ],
            ),
            const Spacer(),
            if (!_isLoading) // Only show favorite button when not loading
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_rounded,
                        color: Colors.pinkAccent),
                    iconSize: 25,
                    onPressed: () async {
                      setState(() => user['isUpdating'] = true);
                      try {
                        int currentFav = user['isFav'] is int
                            ? user['isFav']
                            : int.tryParse(user['isFav'].toString()) ?? 0;
                        int newFav = currentFav == 1 ? 0 : 1;
                        await API_Users().updateUser(
                          {'isFav': newFav},
                          user['id'].toString(),
                        );
                        fetchFavUsers();
                      } finally {
                        setState(() => user['isUpdating'] = false);
                      }
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
