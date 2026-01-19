import 'package:shopping_app/model/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  List<CategoryModel> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {}
