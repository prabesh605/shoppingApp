import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/user_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final userRoleController = TextEditingController();

  UserModel? userData;
  Future<void> getUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .get();
      final UserModel user = UserModel.fromJson(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
      emailController.text = user.email;
      userRoleController.text = user.role;
      passwordController.text = user.password ?? "";
      fullNameController.text = user.fullName ?? "";
      phoneNumberController.text = user.phoneNumber ?? "";
      userData = user;
      // return user;
      // print(doc.data());
    } catch (e) {
      throw Exception(e.toString());
      // return "";
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    userRoleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: fullNameController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: emailController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: phoneNumberController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: passwordController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                readOnly: true,
                controller: userRoleController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              // ListTile(
              //   leading: Icon(Icons.email),
              //   title: Text(
              //     userData?.email ?? "",
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              // ListTile(
              //   leading: Icon(Icons.admin_panel_settings_rounded),
              //   title: Text(userData?.role ?? ""),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
