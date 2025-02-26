import 'package:flutter/material.dart';
import 'package:matrimonial_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var nameVal = 'No data';

  @override
  void initState() {
    super.initState();
    getPref();
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
            const SizedBox(width: 10),
            const Text(
              "JanmoKeSathi",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(255, 48, 48, 0.8),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/imgs/logo.png", height: 50, width: 50),
            const Text(
              "JanmoKeSathi",
              style: TextStyle(fontSize: 35, fontFamily: "titleFont", fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Enter your Email",
                  prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print("Login Pressed");

                var email = emailController.text.toString();
                var pref = await SharedPreferences.getInstance();

                bool success = await pref.setString("email", email);
                if (success) {
                  print("Email saved successfully");
                } else {
                  print("Failed to save email");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                "LogIn",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void getPref() async {
    var pref = await SharedPreferences.getInstance();
    var prefName = pref.getString("email") ?? "No data";

    setState(() {

    });

    if (prefName == "hetbhaiop") {

      print("done");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle,
                  color: Colors.green),
              SizedBox(width: 8),
              Text(
                  "Login successfully!"),
            ],
          ),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      print("nathi");
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.cancel_outlined,
                  color: Colors.red),
              SizedBox(width: 8),
              Text(
                  "Enter correct email"),
            ],
          ),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
