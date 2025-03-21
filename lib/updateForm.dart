import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_app/PageViewBuilder.dart';
import 'package:matrimonial_app/crudAPI.dart';
import 'package:matrimonial_app/db.dart';
import 'package:matrimonial_app/favUser.dart';
import 'package:matrimonial_app/home.dart';
import 'package:matrimonial_app/user.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/userList.dart';

// class User {
//   String name;
//   String email;
//   String phone;
//   String dob;
//   String city;
//   String gender;
//   int isFav;
//   // String hobbies;
//   // String password;
//
//   User({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.dob,
//     required this.city,
//     required this.gender,
//     required this.isFav,
//     // required this.hobbies,
//     // required this.password,
//   });
// }

class UpdateUser extends StatefulWidget {
  final Map<String, dynamic> user;
  const UpdateUser({super.key, required this.user}); //searched user mathi j index aave e

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController dob;
  late TextEditingController city;
  late TextEditingController gender;
  late TextEditingController isFav;
  String selectedGender = "";
  String selectedCity = "";

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
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.user['name'].toString());
    email = TextEditingController(text: widget.user['email'].toString());
    phone = TextEditingController(text: widget.user['phone'].toString());
    dob = TextEditingController(text: widget.user['dob'].toString());
    city = TextEditingController(text: widget.user['city'].toString());
    gender = TextEditingController(text: widget.user['gender'].toString());
    isFav = TextEditingController(text: widget.user['isFav'].toString());
    selectedGender = widget.user['gender'].toString();
    
    // Set selectedCity to a valid value or fallback to a default
    selectedCity = cities.contains(widget.user['city'].toString())
        ? widget.user['city'].toString()
        : cities[0];
    print("======================update vada use ni city ${widget.user['city']} =================================");
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
              SizedBox(width: 10,),
              const Text(
                "JanmoKeSathi",
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Color(0xff69247C)
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
                  "User Update Form",
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
                          controller: phone,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
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
                                      Radio<String>(
                                        value: "Male",
                                        groupValue: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
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
                                      Radio<String>(
                                        value: "Female",
                                        groupValue: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
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
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year - 22),
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
                            int requiredAge = selectedGender == "Male" ? 21 : 18;
                            // print(DateTime.now().year.toString());
                            if (age < requiredAge) {
                              setState(() {
                                isValiddob = false;
                              });
                              // print("no");
                              return 'Minimum required age is ${requiredAge} for ${selectedGender}';
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
                              .map<DropdownMenuItem<String>>((String cityValue) {
                            return DropdownMenuItem<String>(
                              value: cityValue,
                              child: Text(cityValue),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue!;
                              // Optionally update your city controller too
                              city.text = newValue;
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Color(0xff69247C),
                                      minimumSize: Size(10, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Match gradient corners
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (fk.currentState!.validate()) {
                                        API_Users a1 = API_Users();

                                        await a1.updateUser({
                                          'name': name.text,
                                          'email': email.text,
                                          'phone': phone.text,
                                          'dob': dob.text,
                                          'city': city.text,
                                          'gender': selectedGender,
                                          'isFav': int.parse(isFav.text), // convert isFav to int if needed
                                        },
                                        widget.user['id']
                                        );
                                        name.clear();
                                        email.clear();
                                        phone.clear();
                                        dob.clear();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("User Updated successfully!"),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Pageviewbuilder(initialIndex: 1,)),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Please fill all fields correctly"),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
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
    );
  }
}