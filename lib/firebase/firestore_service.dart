import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/model/cart_model.dart';
import 'package:shopping_app/model/category_model.dart';
import 'package:shopping_app/model/product_model.dart';

class FirestoreService {
  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection("category");
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection("product");
  final CollectionReference cartCollection = FirebaseFirestore.instance
      .collection("cart");
  Future<void> addCategory(CategoryModel data) async {
    try {
      await categoryCollection.add(data.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addProduct(ProductModel data) async {
    try {
      await productCollection.add(data.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addToCart(CartModel data) async {
    try {
      await cartCollection.add(data.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    try {
      final data = await categoryCollection.get();
      final List<CategoryModel> category = data.docs
          .map(
            (doc) => CategoryModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ),
          )
          .toList();
      return category;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductModel>> getProduct() async {
    try {
      final data = await productCollection.get();
      final List<ProductModel> products = data.docs
          .map(
            (docs) => ProductModel.fromJson(
              docs.data() as Map<String, dynamic>,
              id: docs.id,
            ),
          )
          .toList();
      return products;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CartModel>> getCart() async {
    try {
      final data = await cartCollection.get();
      final List<CartModel> carts = data.docs
          .map(
            (docs) => CartModel.fromJson(
              docs.data() as Map<String, dynamic>,
              id: docs.id,
            ),
          )
          .toList();
      return carts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
