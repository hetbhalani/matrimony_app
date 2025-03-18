import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class API_Users{
  Future<void> addUser(String name, String email, String phone, String dob, String city, String gender,List<String> hobbies, int isFav)async{
    final body = {
      'name': name, 'email': email, 'phone': phone, 'dob': dob, 'city': city, 'gender': gender,'hobbies': hobbies.join(','), 'isFav': isFav
    };

    final url = "https://67c70421c19eb8753e7845fe.mockapi.io/Matrimony_app";
    final uri = Uri.parse(url);

    final response = await http.post(uri,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"}
    );

    if(response.statusCode == 201){
      print("Success");
      print(response.body);
    }
  }

  Future<List<Map<String, dynamic>>> fetchUser()async{
    final url = "https://67c70421c19eb8753e7845fe.mockapi.io/Matrimony_app";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.body);
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }

  Future<void> updateUser(Map<String, dynamic> user,String id)async{

    final url = "https://67c70421c19eb8753e7845fe.mockapi.io/Matrimony_app/$id";
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(user),
        headers: {"Content-Type": "application/json"}
    );
    print(response.body);
    print("Updated");
  }

  Future<void> deleteUser (String id) async{
    final uri = Uri.parse('https://67c70421c19eb8753e7845fe.mockapi.io/Matrimony_app/$id');
    try{
      final response = await http.delete(uri);
      if (response.statusCode == 200) {
        print("User deleted successfully!");
      } else {
        print("Failed to delete user: ${response.statusCode}");
      }
    }catch(e){
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getFavouriteUsers() async {
    List<Map<String, dynamic>> allUsers = await fetchUser();
    
    List<Map<String, dynamic>> favUsers = allUsers.where((user) {
      int fav = user['isFav'] is int
          ? user['isFav']
          : int.parse(user['isFav'].toString()) ?? 0;
      return fav == 1;
    }).toList();
    
    return favUsers;
  }
}