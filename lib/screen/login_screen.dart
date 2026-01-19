import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screen/admin_module/admin_navigation_bar.dart';
import 'package:shopping_app/screen/user_module/dashboard_screen.dart';
import 'package:shopping_app/screen/user_module/navigation_bar.dart';
import 'package:shopping_app/screen/signup_screen.dart';
import 'package:shopping_app/service/user_role_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserRoleService userRoleService = UserRoleService();

  Future<User?> login() async {
    try {
      final data = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? users = data.user;
      saveUserEmail(users?.email ?? "");

      print(users?.email);

      // print(data);
      return users;
    } catch (e) {
      throw Exception(e.toString());
      // print(e.toString());
    }
  }

  Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/shopLogo.png", height: 150),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final User? user = await login();
                    if (user!.uid.isNotEmpty) {
                      final String role =
                          await userRoleService.getUserRole() ?? "";
                      if (role.isNotEmpty || role != null) {
                        // print(role);
                        role == 'admin'
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AdminNavigationBar(role: role),
                                ),
                              )
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NavigationScreen(role: role),
                                ),
                              );
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  "Signup to create new Account",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
