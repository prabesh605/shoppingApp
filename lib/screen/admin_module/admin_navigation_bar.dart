import 'package:flutter/material.dart';
import 'package:shopping_app/screen/admin_module/admin_dashboard.dart';
import 'package:shopping_app/screen/admin_module/user_profile.dart';
import 'package:shopping_app/screen/cart_screen.dart';
import 'package:shopping_app/screen/dashboard_screen.dart';
import 'package:shopping_app/screen/manage_order_screen.dart';
import 'package:shopping_app/screen/user_order_screen.dart';

class AdminNavigationBar extends StatefulWidget {
  const AdminNavigationBar({super.key, required this.role});
  final String role;

  @override
  State<AdminNavigationBar> createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int selectedIndex = 0;
  final List pages = [
    AdminDashboard(),
    ManageOrderScreen(),
    // Center(child: Text("Profile Page")),
    // CartScreen(),
    // UserOrderScreen(),
    UserProfile(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,

        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart, color: Colors.white),
          //   label: "Cart",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.white),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
