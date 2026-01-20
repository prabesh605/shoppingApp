import 'package:shopping_app/model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> carts;
  CartLoaded(this.carts);
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
