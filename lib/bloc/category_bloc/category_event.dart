import 'package:shopping_app/model/category_model.dart';

abstract class CategoryEvent {}

class GetCategory extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final CategoryModel category;
  AddCategory(this.category);
}
