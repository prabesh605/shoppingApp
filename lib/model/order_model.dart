import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/model/cart_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String email;
  final double totalAmount;
  final String status;
  final DateTime createdDate;
  final List<CartModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.totalAmount,
    required this.status,
    required this.createdDate,
    required this.items,
  });
  factory OrderModel.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userId: data['userId'],
      email: data['email'],
      totalAmount: (data['totalAmount'] as num).toDouble(),
      status: data['status'],
      createdDate: (data['createdAt'] as Timestamp).toDate(),
      items: (doc['items'] as List)
          .map((e) => CartModel.fromJson(e, id: doc.id))
          .toList(),
      // items: List<CartModel>.from(data['items']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': Timestamp.fromDate(createdDate),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
