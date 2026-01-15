import 'package:flutter/material.dart';
import 'package:shopping_app/screen/admin_module/admin_navigation_bar.dart';
import 'package:shopping_app/screen/dashboard_screen.dart';
import 'package:shopping_app/screen/login_screen.dart';
import 'package:shopping_app/screen/navigation_bar.dart';
import 'package:shopping_app/service/user_role_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      handleUser();
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      // );
    });
  }

  Future<void> handleUser() async {
    final role = await UserRoleService().getUserRole() ?? "";
    if (role == 'admin' || role == 'user') {
      role == 'admin'
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminNavigationBar(role: role),
                // DashboardScreen(role: role)
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationScreen(role: role),
                // DashboardScreen(role: role)
              ),
            );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/shopLogo.png"),
              Text("Welcome to MyShop"),
            ],
          ),
        ),
      ),
    );
  }
}
