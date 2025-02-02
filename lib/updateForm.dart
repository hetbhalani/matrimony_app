import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_app/UserList.dart';
import 'package:matrimonial_app/favUser.dart';
import 'package:matrimonial_app/home.dart';
import 'package:matrimonial_app/user.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class User {
  String name;
  String email;
  String phone;
  String dob;
  String city;
  bool gender;
  bool isFav;
  // String hobbies;
  // String password;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.city,
    required this.gender,
    required this.isFav,
    // required this.hobbies,
    // required this.password,
  });
}

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController city = TextEditingController();
  // TextEditingController gender = TextEditingController();
  // TextEditingController hobbies = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isMale = true;

  String? selectedCity;
  List<String> cities = [
    'Junagadh',
    'Rajkot',
    'Surat',
    'Nadiad',
    'Ahmdabad',
    'Vadodara'
  ];
  bool isPasswordHidden = true;
  bool isValidName = true;
  bool isValidEmail = true;
  bool isValidpass = true;
  bool isValidphone = true;
  bool isValiddob = true;
  bool isValidcity = true;

  GlobalKey<FormState> fk = GlobalKey();
  int _selectedIndex = 1;
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
            SizedBox(width: 10,),
            const Text(
              "JanmoKeSathi",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 34, 34, 0.8),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color.fromRGBO(188, 18, 238, 0.5),
        //         Color.fromRGBO(255, 100, 200, 0.5),
        //       ],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(18),
          // padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white, // Background color for the container
            borderRadius: BorderRadius.circular(15), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 10), // Shadow position
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Text(
                  "User Registration Form",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 34, 34, 0.8)),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: fk,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: name,
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: "User Name",
                            prefixIcon: Icon(Icons.account_circle_rounded,
                                color:
                                isValidName ? Colors.black54 : Colors.red),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                isValidName = false;
                              });
                              return 'Please enter your name';
                            } else {
                              setState(() {
                                isValidName = true;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          // maxLength: 80,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_outlined,
                                color:
                                isValidEmail ? Colors.black54 : Colors.red),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                isValidEmail = false;
                              });
                              return 'Please enter your name';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              setState(() {
                                isValidEmail = false;
                              });
                              return 'Please enter a valid email';
                            } else {
                              setState(() {
                                isValidEmail = true;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: isPasswordHidden,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock,
                                color:
                                isValidpass ? Colors.black54 : Colors.red),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                                icon: Icon(
                                  isPasswordHidden
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                isValidpass = false;
                              });
                              return 'Please enter password';
                            }
                            if (value.length < 8) {
                              setState(() {
                                isValidpass = false;
                              });
                              return 'Enter at least 8 digit Password';
                            } else {
                              setState(() {
                                isValidpass = true;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: phone,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],                          decoration: InputDecoration(
                          labelText: "Mobile Number",
                          prefixIcon: Icon(Icons.phone,
                              color:
                              isValidphone ? Colors.black54 : Colors.red),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                isValidphone = false;
                              });
                              return 'Please enter your phone number';
                            }
                            if (value.length != 10 ||
                                !RegExp(r'^\d+$').hasMatch(value)) {
                              setState(() {
                                isValidphone = false;
                              });
                              return 'Please enter a valid 10-digit phone number';
                            } else {
                              setState(() {
                                isValidphone = true;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: isMale,
                                        onChanged: (value) {
                                          setState(() {
                                            isMale = value!;
                                          });
                                        },
                                      ),
                                      Text("Male"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Radio<bool>(
                                        value: false,
                                        groupValue: isMale,
                                        onChanged: (value) {
                                          setState(() {
                                            isMale = value!;
                                          });
                                        },
                                      ),
                                      Text("Female"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: dob,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Date of Birth",
                            prefixIcon: Icon(Icons.calendar_today,
                                color: isValiddob
                                    ? Colors.black54
                                    : Colors.red), // Calendar icon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () async {
                            // Open the date picker when tapped
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                dob.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                isValiddob = false;
                              });
                              return 'Please select your date of birth';
                            }
                            List split = value.split('-');
                            int age = DateTime.now().year - int.parse(split[2]);
                            int requiredAge = isMale ? 21 : 18;
                            // print(DateTime.now().year.toString());
                            if (age < requiredAge) {
                              setState(() {
                                isValiddob = false;
                              });
                              // print("no");
                              return 'Minimum required age is ${requiredAge} for ${isMale?'Male':'Female'}';
                            } else {
                              setState(() {
                                isValiddob = true;
                              });
                            }
                            // else{
                            //   print("yesssss");
                            // }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedCity,
                          focusColor: Colors.transparent,
                          decoration: InputDecoration(
                            labelText: "Select Your City",
                            prefixIcon: Icon(Icons.location_city,
                                color:
                                isValidcity ? Colors.black54 : Colors.red),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          items: cities
                              .map<DropdownMenuItem<String>>((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity =
                                  newValue; // Update the selected city
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                isValidcity = false;
                              });
                              return 'Plsese select your City';
                            } else {
                              setState(() {
                                isValidcity = true;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       Color.fromRGBO(188, 18, 238, 0.5),
                          //       Color.fromRGBO(255, 100, 200, 0.5),
                          //     ],
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.bottomRight,
                          //   ),
                          //   borderRadius: BorderRadius.circular(12), // Match button corners
                          // ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Color.fromRGBO(255, 48, 48, 0.8),
                                      minimumSize: Size(10, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Match gradient corners
                                      ),
                                    ),
                                    onPressed: () {
                                      if (fk.currentState!.validate()) {
                                        User newUser = User(
                                            name: name.text,
                                            email: email.text,
                                            phone: phone.text,
                                            dob: dob.text,
                                            city: selectedCity ?? '',
                                            gender: isMale,
                                            isFav:false
                                          // hobbies: selectedHobbiesString,
                                          // password: password.text,
                                        );

                                        setState(() {
                                          users.insert(0,{
                                            'name': newUser.name,
                                            'email': newUser.email,
                                            'phone': newUser.phone,
                                            'dob': newUser.dob,
                                            'city': newUser.city,
                                            'gender': newUser.gender,
                                            'isFav': newUser.isFav,
                                            // 'hobbies': newUser.hobbies,
                                            // 'password': newUser.password,
                                          });
                                        });
                                        name.clear();
                                        email.clear();
                                        phone.clear();
                                        dob.clear();
                                        password.clear();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.check_circle,
                                                    color: Colors.green),
                                                SizedBox(width: 8),
                                                Text(
                                                    "User added successfully!"),
                                              ],
                                            ),
                                            backgroundColor: Colors.black87,
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 3),
                                          ),
                                        );

                                        print(users);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.cancel_outlined,
                                                    color: Colors.red),
                                                SizedBox(width: 8),
                                                Text(
                                                    "Please fill all fields correctly"),
                                              ],
                                            ),
                                            backgroundColor: Colors.black87,
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        print(users);
                                      }
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white, // Text color
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Color.fromRGBO(255, 48, 48, 0.8),
                                      minimumSize: Size(10, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Match gradient corners
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        name.clear();
                                        email.clear();
                                        password.clear();
                                        phone.clear();
                                        dob.clear();
                                        city.clear();
                                      });
                                    },
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white, // Text color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                  icon: Icons.home,
                  text: 'Home',
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                  },
                ),
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
                  icon: Icons.favorite,
                  text: 'Favorite',
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FavUsers()));
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
