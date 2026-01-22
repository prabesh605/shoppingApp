import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/model/user_model.dart';
import 'package:shopping_app/screen/admin_module/admin_navigation_bar.dart';
import 'package:shopping_app/screen/user_module/dashboard_screen.dart';
import 'package:shopping_app/screen/user_module/navigation_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String? selectedRole;

  List<String> roles = ['admin', 'user'];
  Future<void> registerUser(UserModel user) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.uid)
        .set(user.toJson());

    // .set({'email': emailController.text, "role": "user"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Sign Up")),
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
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
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
                  controller: fullNameController,
                  decoration: InputDecoration(
                    label: Text("Full Name"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full Name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    label: Text("Phone Number"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone Number is required';
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
                      return 'Password is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  // initialValue: selectedCategory,
                  value: selectedRole,
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Role is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final user = UserModel(
                        email: emailController.text,
                        role: selectedRole ?? "user",
                        password: passwordController.text,
                        fullName: fullNameController.text,
                        phoneNumber: phoneNumberController.text,
                      );
                      registerUser(user);

                      // print(role);
                      selectedRole == 'admin'
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminNavigationBar(
                                  role: selectedRole ?? "admin",
                                ),
                              ),
                            )
                          : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavigationScreen(
                                  role: selectedRole ?? "user",
                                ),
                              ),
                            );

                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         DashboardScreen(role: selectedRole ?? "user"),
                      //   ),
                      // );
                    }
                  },
                  child: Text("SignUp"),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Already have account. Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
