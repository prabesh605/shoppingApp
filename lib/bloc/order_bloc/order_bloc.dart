import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/order_bloc/order_event.dart';
import 'package:shopping_app/bloc/order_bloc/order_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  FirestoreService service;
  OrderBloc(this.service) : super(OrderInitial()) {
    on<GetOrder>((event, emit) async {
      emit(OrderLoading());
      final orders = await service.getMyOrder();
      emit(OrderLoaded(orders));
    });
    on<AddOrder>((event, emit) async {
      emit(OrderLoading());
      await service.addOrder(event.order);
      final orders = await service.getMyOrder();
      emit(OrderLoaded(orders));
    });
    on<GetAllOrder>((event, emit) async {
      emit(OrderLoading());
      final orders = await service.getAllOrder();
      emit(OrderLoaded(orders));
    });
  }
}

// class OrderBloc extends Bloc<OrderEvent, OrderState> {
//   FirestoreService service;
//   OrderBloc(this.service) : super(OrderInitial()) {
//     on<GetOrder>((event, emit) async {
//       emit(OrderLoading());
//       final orders = await service.getOrder();
//       emit(OrderLoaded(orders as List<OrderModel> ));
//     });
//     on<AddOrder>((event, emit) async {
//       emit(OrderLoading());
//       await service.addToCart(event.cart);
//     });
//   }
// }
