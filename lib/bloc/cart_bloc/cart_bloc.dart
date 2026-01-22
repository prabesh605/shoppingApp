import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/cart_bloc/cart_event.dart';
import 'package:shopping_app/bloc/cart_bloc/cart_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  FirestoreService service;
  CartBloc(this.service) : super(CartInitial()) {
    on<GetCart>((event, emit) async {
      emit(CartLoading());
      final carts = await service.getCart();
      emit(CartLoaded(carts));
    });
    on<AddCart>((event, emit) async {
      emit(CartLoading());
      await service.addToCart(event.cart);
      final carts = await service.getCart();
      emit(CartLoaded(carts));
    });
    on<RemoveCart>((event, emit) async {
      emit(CartLoading());
      await service.removeCart();
      final carts = await service.getCart();
      emit(CartLoaded(carts));
    });
    on<RemoveCartById>((event, emit) async {
      emit(CartLoading());
      await service.removeCartById(event.id);
      final carts = await service.getCart();
      emit(CartLoaded(carts));
    });
  }
}
