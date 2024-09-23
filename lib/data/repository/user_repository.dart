import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl =
      'https://pocketbase.io/api'; // Replace with your API URL

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> addUser(String name, String email, String password,
      String confirmPassword, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'role': role,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }
  }

  Future<void> editUser(int id, String name, String email, String password,
      String confirmPassword, String role) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'role': role,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit user');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UserRepository {
//    final String apiUrl;
 
//   UserRepository({required this.apiUrl});

//   // Fetch users from API
//   Future<List<Map<String, dynamic>>> fetchUsers() async {
//     final response = await http.get(Uri.parse('$apiUrl/users'));

//     if (response.statusCode == 200) {
//       return List<Map<String, dynamic>>.from(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }

//   // Add user via API
//   Future<void> addUser(String name, String email, String password,
//       String confirmPassword, String role) async {
//     final response = await http.post(
//       Uri.parse('$apiUrl/collections/users/records'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'name': name,
//         'email': email,
//         'password': password,
//         'confirmPassword': confirmPassword,
//         'role': role,
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add user');
//     }
//   }

//   // Edit user via API
//   Future<void> editUser(int id, String name, String email, String password,
//       String confirmPassword, String role) async {
//     final response = await http.put(
//       Uri.parse('$apiUrl/collections/users/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'name': name,
//         'email': email,
//         'password': password,
//         'confirmPassword': confirmPassword,
//         'role': role,
//       }),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to edit user');
//     }
//   }

//   // Delete user via API
//   Future<void> deleteUser(int id) async {
//     final response = await http.delete(Uri.parse('$apiUrl/users/$id'));

//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete user');
//     }
//   }
// }
