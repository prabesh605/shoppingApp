import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/category_bloc/category_event.dart';
import 'package:shopping_app/bloc/category_bloc/category_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/category_model.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  FirestoreService service;
  CategoryBloc(this.service) : super(CategoryInitial()) {
    on<GetCategory>((event, emit) async {
      emit(CategoryLoading());
      final List<CategoryModel> categories = await service.getCategory();
      emit(CategoryLoaded(categories));
    });
    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      await service.addCategory(event.category);
      final List<CategoryModel> categories = await service.getCategory();
      emit(CategoryLoaded(categories));
    });
  }
}
