import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_app_with_api/screen/product_management.dart';
import 'package:flutter_shopping_app_with_api/screen/user_management.dart';
import 'package:flutter_shopping_app_with_api/screen/category_management.dart';
import 'package:flutter_shopping_app_with_api/auth/auth.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/user_bloc.dart';
import 'package:flutter_shopping_app_with_api/data/repository/user_repository.dart';
// Import UsersScreen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Welcome, User'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Users'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          UserBloc(UserRepository()), // Provide UserBloc
                      child: UsersScreen(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: const <Widget>[
            DashboardCard(
                title: '2 Users', icon: Icons.people, color: Colors.red),
            DashboardCard(
                title: '0 Products', icon: Icons.list, color: Colors.green),
            DashboardCard(
                title: '1 Categories',
                icon: Icons.category,
                color: Colors.purple),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(height: 3),
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                if (title == '2 Users') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            UserBloc(UserRepository()), // Provide UserBloc
                        child: UsersScreen(),
                      ),
                    ),
                  );
                } else if (title == '0 Products') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsScreen()),
                  );
                } else if (title == '1 Categories') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                }
              },
              child: const Text('View Details',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
