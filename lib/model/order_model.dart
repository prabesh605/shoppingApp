import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/constant/order_status.dart';
import 'package:shopping_app/model/cart_model.dart';
import 'package:shopping_app/utils/order_status_helper.dart';

class OrderModel {
  final String id;
  final String userId;
  final String email;
  final double totalAmount;
  final OrderStatus status;
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
      status: OrderStatusHelper.fromString(data['status']),
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
      'status': OrderStatusHelper.toStringValue(status),
      'createdAt': Timestamp.fromDate(createdDate),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
