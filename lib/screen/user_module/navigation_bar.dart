import 'package:flutter/material.dart';
import 'package:shopping_app/screen/user_module/cart_screen.dart';
import 'package:shopping_app/screen/user_module/dashboard_screen.dart';
import 'package:shopping_app/screen/user_module/user_order_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, required this.role});
  final String role;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;
  final List pages = [
    DashboardScreen(role: "user"),
    CartScreen(),
    UserOrderScreen(),
    Center(child: Text("Profile Page")),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            label: "Cart",
          ),
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
