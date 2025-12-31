import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class UserRoleService {
//   Future<String> getUserRole() async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     final doc = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(uid)
//         .get();
//     return doc['role'];
//   }
// }
class UserRoleService {
  Future<String?> getUserRole() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .get();
      return doc['role'];
    } catch (e) {
      return "";
    }
  }
}
