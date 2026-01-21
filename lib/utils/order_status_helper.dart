import 'package:shopping_app/constant/order_status.dart';

class OrderStatusHelper {
  static String toStringValue(OrderStatus status) {
    return status.name;
  }

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
