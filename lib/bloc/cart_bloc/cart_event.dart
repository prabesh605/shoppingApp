import 'package:shopping_app/model/cart_model.dart';

abstract class CartEvent {}

class GetCart extends CartEvent {}

class AddCart extends CartEvent {
  final CartModel cart;
  AddCart(this.cart);
}
