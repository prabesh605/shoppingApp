import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/model/cart_model.dart';
import 'package:shopping_app/model/category_model.dart';
import 'package:shopping_app/model/order_model.dart';
import 'package:shopping_app/model/product_model.dart';

class FirestoreService {
  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection("category");
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection("product");
  final CollectionReference cartCollection = FirebaseFirestore.instance
      .collection("cart");
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("Users");
  final CollectionReference orderCollection = FirebaseFirestore.instance
      .collection("order");
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
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await userCollection.doc(uid).collection("cart").add(data.toJson());
      // await cartCollection.add(data.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addOrder(OrderModel data) async {
    try {
      await orderCollection.add(data.toJson());
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
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final data = await userCollection.doc(uid).collection("cart").get();
      // final data = await cartCollection.get();
      final List<CartModel> carts = data.docs
          .map((docs) => CartModel.fromJson(docs.data(), id: docs.id))
          .toList();
      return carts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeCartById(String docId) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await userCollection.doc(uid).collection('cart').doc(docId).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeCart() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      var collection = userCollection.doc(uid).collection('cart');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<OrderModel>> getAllOrder() async {
    try {
      final data = await orderCollection.get();
      final orders = data.docs.map((e) => OrderModel.fromJson(e)).toList();
      return orders;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      await orderCollection.doc(order.id).update(order.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<OrderModel>> getMyOrder() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final data = await orderCollection.get();
      final value = data.docs.where((e) => e['userId'] == uid);
      final result = value.map((e) => OrderModel.fromJson(e)).toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
