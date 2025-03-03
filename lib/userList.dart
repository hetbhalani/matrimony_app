import 'package:flutter/material.dart';
import 'package:matrimonial_app/abotUs.dart';
import 'package:matrimonial_app/db.dart';
import 'package:matrimonial_app/favUser.dart';
import 'package:matrimonial_app/home.dart';
import 'package:matrimonial_app/updateForm.dart';
import 'package:matrimonial_app/user.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// Map<String, dynamic> userForUpdate = {};

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
  List<Map<String, dynamic>> sortedUser = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final users = await db.fetchUsers();
    setState(() {
      allUsers = users;
      searchedUsers = List.from(users);
    });
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
      backgroundColor: Color(0xfff6f0ff),

      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: TextFormField(
                    controller: search,
                    onChanged: filterUsers,
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: DropdownButton<String>(
                    hint: SizedBox(
                      width: 72,
                      child: Row(
                        children: [
                          SizedBox(width: 3),
                          Text("Sort", style: TextStyle(fontSize: 18)),
                          SizedBox(width: 5),
                          Icon(Icons.filter_list, size: 23),
                        ],
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "A to Z",
                        child: Text("A to Z"),
                      ),
                      DropdownMenuItem(
                        value: "Z to A",
                        child: Text("Z to A"),
                      ),
                      DropdownMenuItem(
                        value: "by City",
                        child: Text("by City"),
                      ),
                      DropdownMenuItem(
                        value: "by Age",
                        child: Text("by Age"),
                      ),
                    ],
                    icon: SizedBox.shrink(),
                    onChanged: (String? val) {
                      print("selected:$val");
                      print(sortItems(val));
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: searchedUsers.isEmpty
                ? Center(child: Text('No users found'))
                : ListView.builder(
                    itemCount: searchedUsers.length,
                    itemBuilder: (context, index) {
                      final user = searchedUsers[index];
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
                                    contentPadding: EdgeInsets.all(
                                        20), // Padding for neat UI
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                              user['gender'] == "Male"
                                                  ? 'assets/imgs/male.png'
                                                  : 'assets/imgs/female.png',
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            user['name'],
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
                                                  value: user['email'],
                                                ),
                                                userInfo(
                                                  icon: Icons.phone,
                                                  label: "Phone",
                                                  value: user['phone'],
                                                ),
                                                userInfo(
                                                    icon: Icons.person,
                                                    label: "Gender",
                                                    value: user['gender']),
                                                userInfo(
                                                  icon: Icons
                                                      .sports_esports_outlined,
                                                  label: "Hobbies",
                                                  value: user['hobbies'] != null
                                                      ? (user['hobbies']
                                                              as List)
                                                          .join(", ")
                                                      : "No hobbies",
                                                ),
                                                userInfo(
                                                  icon: Icons
                                                      .location_city_outlined,
                                                  label: "City",
                                                  value: user['city'],
                                                ),
                                                userInfo(
                                                  icon: Icons.cake_rounded,
                                                  label: "Age",
                                                  value:
                                                      "${calcAge(user['dob'])} Years",
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
                                                color: Colors.red,
                                                fontSize: 16)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              user['gender'] == "Male"
                                                  ? 'assets/imgs/male.png'
                                                  : 'assets/imgs/female.png',
                                              height: 35,
                                              width: 35,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              "${user['name']}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "City:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(width: 8),
                                              Text(user['city']),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 5, 0, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Phone:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(width: 10),
                                              Text(user['phone']),
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
                                          icon: user['isFav'] == 1
                                              ? Icon(Icons.favorite_rounded,
                                                  color: Colors.pinkAccent)
                                              : Icon(Icons
                                                  .favorite_border_rounded),
                                          iconSize: 25,
                                          onPressed: () async {
                                            await db.updateUser(
                                              id: user['id'],
                                              isFav: user['isFav'] == 0 ? 1 : 0,
                                            );
                                            loadUsers();
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          iconSize: 25,
                                          color: Colors.blueAccent,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => UpdateUser(user: searchedUsers[index]),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          iconSize: 25,
                                          color: Colors.red,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text("Are You Sure?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              Text("Cancel")),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await db.deleteUser(
                                                                user['id']);
                                                            loadUsers();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .delete_outline_rounded,
                                                                        color: Colors
                                                                            .red),
                                                                    SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                        "User Deleted successfully!"),
                                                                  ],
                                                                ),
                                                                backgroundColor:
                                                                    Colors
                                                                        .black87,
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
                                                              ),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          )),
                                                    ],
                                                  );
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
    );
  }

  int calcAge(String val) {
    List split = val.split('-');
    return ((DateTime.now().year)) - int.parse(split[2]);
  }

  Widget userInfo(
      {required IconData icon, required String label, required String value}) {
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

  List<Map<String, dynamic>> sortItems(String? selectedValue) {
    List<Map<String, dynamic>> sortedList = List.from(searchedUsers);
    setState(() {
      if (selectedValue == "A to Z") {
        searchedUsers.sort((a, b) => a['name'].compareTo(b['name']));
      }
      else if (selectedValue == "Z to A") {
        searchedUsers.sort((a, b) => b['name'].compareTo(a['name']));
      }
      else if (selectedValue == "by City") {
        searchedUsers.sort((a, b) =>
            a['city'].toLowerCase().compareTo(b['city'].toLowerCase()));
      }
      else if (selectedValue == "by Age") {
        searchedUsers
            .sort((a, b) => calcAge(a['dob']).compareTo(calcAge(b['dob'])));
      }
      sortedUser = sortedList;
    });
    return sortedUser;
  }
}
