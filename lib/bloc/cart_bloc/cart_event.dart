import 'package:shopping_app/model/cart_model.dart';

abstract class CartEvent {}

class GetCart extends CartEvent {}

class AddCart extends CartEvent {
  final CartModel cart;
  AddCart(this.cart);
}

class RemoveCart extends CartEvent {}

class RemoveCartById extends CartEvent {
  String id;
  RemoveCartById(this.id);
}
