import 'package:shopping_app/model/product_model.dart';

abstract class ProductEvent {}

class GetProduct extends ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel product;
  AddProduct(this.product);
}
