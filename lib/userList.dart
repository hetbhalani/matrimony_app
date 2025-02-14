import 'package:flutter/material.dart';
import 'package:matrimonial_app/db.dart';
import 'package:matrimonial_app/favUser.dart';
import 'package:matrimonial_app/home.dart';
import 'package:matrimonial_app/updateForm.dart';
import 'package:matrimonial_app/user.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'abotUs.dart';
// import 'package:line_icons/line_icons.dart';

Map<String,dynamic> userForUpdate = {};

class Userlist extends StatefulWidget {
  const Userlist({super.key});

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  final MatrimonyDB db = MatrimonyDB();
  TextEditingController search = TextEditingController();
  int _selectedIndex = 1;
  final List<Widget> _pages = [
    HomePage(),
    CrudUser(),
    Userlist(),
    Center(child: Text('Favorites')),
  ];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  List<Map<String, dynamic>> searchedUsers = [];
  List<Map<String, dynamic>> allUsers = [];


  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers(){
    Future<void> loadUsers() async {
      final users = await db.fetchUsers();
      setState(() {
        allUsers = users;
        searchedUsers = List.from(users);
      });
    }
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        searchedUsers = List.from(allUsers);
      } else {
        searchedUsers = allUsers.where((user) {
          return user['name'].toLowerCase().contains(query.toLowerCase()) ||
              user['city'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextFormField(
              controller: search,
              onChanged: (value) {
                filterUsers(value);
              },
              decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedUsers.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)), // Rounded Corners
                              contentPadding:
                                  EdgeInsets.all(20), // Padding for neat UI
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        searchedUsers[index]['gender']
                                            ? 'assets/imgs/male.png'
                                            : 'assets/imgs/female.png',
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      searchedUsers[index]['name'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userInfo(
                                            icon: Icons.email_outlined,
                                            label: "Email",
                                            value: searchedUsers[index]['email'],
                                          ),
                                          userInfo(
                                            icon: Icons.phone,
                                            label: "Phone",
                                            value: searchedUsers[index]['phone'],
                                          ),
                                          userInfo(
                                            icon: Icons.person,
                                            label: "Gender",
                                            value: searchedUsers[index]['gender'] ? "Male" : "Female",
                                          ),
                                          userInfo(
                                            icon: Icons.sports_esports_outlined,
                                            label: "Hobbies",
                                            value: allUsers[index]['hobbies'] != null
                                                ? (allUsers[index]['hobbies'] as List).join(", ")
                                                : "No hobbies",
                                          ),
                                          userInfo(
                                            icon: Icons.location_city_outlined,
                                            label: "City",
                                            value: searchedUsers[index]['city'],
                                          ),
                                          userInfo(
                                            icon: Icons.cake_rounded,
                                            label: "Age",
                                            value: "${calcAge(searchedUsers[index]['dob'])} Years",
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Close",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        searchedUsers[index]['gender']
                                            ? 'assets/imgs/male.png'
                                            : 'assets/imgs/female.png',
                                        height: 35,
                                        width: 35,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        "${searchedUsers[index]['name']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "City:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(width: 8),
                                        Text(searchedUsers[index]['city']),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 5, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Phone:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(width: 10),
                                        Text(searchedUsers[index]['phone']),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: searchedUsers[index]['isFav']
                                        ? Icon(Icons.favorite_rounded,
                                            color: Colors.pinkAccent)
                                        : Icon(Icons.favorite_border_rounded),
                                    iconSize: 25,
                                    onPressed: () {
                                      setState(() {
                                        if (!allUsers[index]['isFav']) {
                                          FavUser.add(allUsers[index]);
                                        } else {
                                          FavUser.removeWhere((user) =>
                                              user['email'] ==
                                                  allUsers[index]['email']);
                                        }
                                        print(FavUser);
                                        print("Fav btn pressed");
                                        allUsers[index]['isFav'] =
                                            !allUsers[index]['isFav'];
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    iconSize: 25,
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      print("Edit button pressed");
                                      userForUpdate.addAll(searchedUsers[index]);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateUser(userIndex: index)));
                                      print(userForUpdate);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 25,
                                    color: Colors.red,
                                    onPressed: () {
                                      print("Delete button pressed");
                                      showDialog(context: context, builder: (BuildContext context){
                                        return AlertDialog(title: Text("Are You Sure?"),actions: [
                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text("cancle")),
                                          TextButton(onPressed: (){
                                            setState(() {
                                              searchedUsers.removeAt(index);
                                              allUsers.removeAt(index);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Row(
                                                    children: [
                                                      Icon(Icons.delete_outline_rounded,
                                                          color: Colors.red),
                                                      SizedBox(width: 8),
                                                      Text(
                                                          "User Deleted successfully!"),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.black87,
                                                  behavior: SnackBarBehavior.floating,
                                                  duration: Duration(seconds: 3),
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                            });
                                          }, child: Text("Delete",style: TextStyle(color: Colors.red),)),
                                        ],);
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => CrudUser()));
                  },
                ),
                GButton(
                  icon: Icons.list_alt_rounded,
                  text: 'User List',
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Userlist()));
                  },
                ),
                GButton(
                  icon: Icons.favorite_border_rounded,
                  text: 'Favorite',
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => FavUsers()));
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FavUsers()));
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

  int calcAge(String val) {
    List split = val.split('-');
    return ((DateTime.now().year)) - int.parse(split[2]);
  }

  Widget userInfo({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent, size: 22),
          SizedBox(width: 10),
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

}
