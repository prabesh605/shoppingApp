import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/product_bloc/product_event.dart';
import 'package:shopping_app/bloc/product_bloc/product_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirestoreService service;
  ProductBloc(this.service) : super(ProductInitial()) {
    on<GetProduct>((event, emit) async {
      emit(ProductLoading());
      final products = await service.getProduct();
      emit(ProductLoaded(products));
    });
    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      await service.addProduct(event.product);
      final products = await service.getProduct();
      emit(ProductLoaded(products));
    });
  }
}
