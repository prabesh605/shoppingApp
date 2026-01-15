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
      );
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 60, backgroundColor: Colors.blueAccent),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  userData?.email ?? "",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings_rounded),
                title: Text(userData?.role ?? ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
