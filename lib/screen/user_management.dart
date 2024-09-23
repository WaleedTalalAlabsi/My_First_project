import 'package:flutter/material.dart';
import 'package:flutter_shopping_app_with_api/screen/dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/user_event.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/user_state.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/user_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreen();
}

class _UsersScreen extends State<UsersScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String userType = 'Select Role';
  int? editingUserId; // To track which user is being edited

  // Mock data
  // List<Map<String, dynamic>> userList = [
  //   {
  //     'id': 1,
  //     'name': 'John Doe',
  //     'email': 'john.doe@example.com',
  //     'isActive': true,
  //     'role': 'Admin',
  //     'Password': '******',
  //     'Confirm Password': '******'
  //   },
  //   {
  //     'id': 2,
  //     'name': 'Jane Smith',
  //     'email': 'jane.smith@example.com',
  //     'isActive': false,
  //     'role': 'User',
  //     'Password': '******',
  //     'Confirm Password': '******'
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardScreen()));
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Welcome, User'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Add logout functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return Column(
              children: <Widget>[
                // User input form
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 2),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        editingUserId == null ? 'Add User' : 'Edit User',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      _buildTextField(nameController, 'Name'),
                      _buildTextField(emailController, 'Email'),
                      _buildTextField(passwordController, 'Password',
                          obscureText: true),
                      _buildTextField(
                          confirmPasswordController, 'Confirm Password',
                          obscureText: true),
                      DropdownButton<String>(
                        value: userType,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            userType = newValue!;
                          });
                        },
                        items: <String>['Select Role', 'Admin', 'User']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (editingUserId == null) {
                                // Add user logic
                                context.read<UserBloc>().add(
                                      AddUser(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                        role: userType,
                                      ),
                                    );
                              } else {
                                // Update user logic
                                context.read<UserBloc>().add(
                                      EditUser(
                                        id: editingUserId!,
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                        role: userType,
                                      ),
                                    );
                                // Reset after editing
                                setState(() {
                                  editingUserId = null;
                                });
                              }
                              _clearForm();
                            },
                            child: Text(editingUserId == null
                                ? 'Add User'
                                : 'Save Changes'),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              _clearForm();
                              setState(() {
                                editingUserId = null;
                              });
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Scrollable user list
                Expanded(
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return Card(
                        child: ListTile(
                          leading: Text(user['id'].toString()),
                          title: Text(user['name']),
                          subtitle: Text(user['email']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Populate the form fields for editing
                                  setState(() {
                                    nameController.text = user['name'];
                                    emailController.text = user['email'];
                                    userType = user['role'];
                                    editingUserId = user['id'];
                                    passwordController.text = user['Password'];
                                    confirmPasswordController.text =
                                        user['Confirm Password'];
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context.read<UserBloc>().add(
                                        DeleteUser(user['id']),
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {
      userType = 'Select Role';
    });
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
//   Widget _buildTextField(TextEditingController controller, String hint,
//       {bool obscureText = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           hintText: hint,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//         ),
//       ),
//     );
//   }

//   // Add or Edit User logic
//   void _addOrEditUser() {
//     if (editingUserId == null) {
//       // Add user
//       setState(() {
//         userList.add({
//           'id': userList.length + 1,
//           'name': nameController.text,
//           'email': emailController.text,
//           'isActive': true,
//           'role': userType,
//           'Pasword': passwordController.text,
//           'Confirm Password': confirmPasswordController.text,
//         });
//       });
//     } else {
//       // Edit user
//       setState(() {
//         final user = userList.firstWhere((user) => user['id'] == editingUserId);
//         user['name'] = nameController.text;
//         user['email'] = emailController.text;
//         user['role'] = userType;
//         user['Password'] = passwordController.text;
//         user['Confirm Password'] = confirmPasswordController.text;
//       });
//     }
//     _clearFields(); // Clear fields after adding/editing
//   }

//   void _clearFields() {
//     nameController.clear();
//     emailController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//     setState(() {
//       userType = 'Select Role';
//       editingUserId = null; // Reset editing state
//     });
//   }

//   // Edit user
//   void _editUser(int id) {
//     final user = userList.firstWhere((user) => user['id'] == id);
//     setState(() {
//       nameController.text = user['name'];
//       emailController.text = user['email'];
//       userType = user['role'];
//       editingUserId = id; // Track which user is being edited
//       passwordController.text = user['Password'];
//       confirmPasswordController.text = user['Confirm Password'];
//     });
//   }

//   // Delete user
//   void _deleteUser(int id) {
//     setState(() {
//       userList.removeWhere((user) => user['id'] == id);
//     });
//   }
// }
