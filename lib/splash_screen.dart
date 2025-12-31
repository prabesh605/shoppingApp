import 'package:flutter/material.dart';
import 'package:shopping_app/screen/dashboard_screen.dart';
import 'package:shopping_app/screen/login_screen.dart';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(role: role)),
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
        child: Center(child: Column(children: [Text("Welcome to MyShop")])),
      ),
    );
  }
}
