// import 'package:shopping_app/model/Order_model.dart';
import 'package:shopping_app/model/order_model.dart';

abstract class OrderEvent {}

class GetOrder extends OrderEvent {}

class AddOrder extends OrderEvent {
  final OrderModel order;
  AddOrder(this.order);
}

class GetAllOrder extends OrderEvent {}
