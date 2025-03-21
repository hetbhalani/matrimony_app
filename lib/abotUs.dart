import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrimonial_app/UserList.dart';
import 'package:matrimonial_app/favUser.dart';
import 'package:matrimonial_app/user.dart';


class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                // backgroundColor: Color.fromRGBO(255, 34, 34, 0.8),
                child: Image.asset('assets/imgs/logo.png'),
              ),
              SizedBox(height: 10),
              Text("JanmoKeSathi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Meet our Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 34, 34, 0.8))),
              ),
              _buildInfoCard([
                _buildInfoRow("Developed by", "Het Bhalani (23010101019)"),
                _buildInfoRow("Mentored by", "Prof. Mehul Bhundiya (Computer Engineering Department)"),
                _buildInfoRow("Explored by", "ASWDC, School Of Computer Science"),
                _buildInfoRow("Eulogized by", "Darshan University, Rajkot, Gujarat - INDIA"),
              ]),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('About ASWDC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 34, 34, 0.8))),
              ),
              _buildInfoCard([
                Text(
                  "ASWDC is an Application, Software and Website Development Center @ Darshan University run by students and staff of the School of Computer Science. \n\nThe sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands, enabling students to learn cutting-edge technologies, develop real-world applications, and gain professional experience under the guidance of industry experts & faculty members.",
                  textAlign: TextAlign.justify,
                )
              ]),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Contact Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 34, 34, 0.8))),
              ),
              _buildInfoCard([
                _buildContactRow(Icons.email, "aswdc@darshan.ac.in"),
                _buildContactRow(Icons.phone, "+91-9727747317"),
                _buildContactRow(Icons.web, "www.darshan.ac.in"),
              ]),
              SizedBox(height: 20),
              _buildActionButtons(),
              SizedBox(height: 20),
              Text("© 2025 Darshan University", style: TextStyle(color: Colors.grey)),
              Text("Made with ❤️ in India", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 34, 34, 0.8))),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(child: Text(value, softWrap: true)),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Color.fromRGBO(255, 34, 34, 0.8)),
          SizedBox(width: 10),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton(FontAwesomeIcons.share, "Share App"),
        _buildIconButton(Icons.apps, "More Apps"),
        _buildIconButton(Icons.star, "Rate Us"),
        _buildIconButton(FontAwesomeIcons.instagram, "Like on Instagram"),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Color.fromRGBO(255, 34, 34, 0.8), size: 28),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}