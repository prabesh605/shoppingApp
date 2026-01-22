import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:shopping_app/bloc/cart_bloc/cart_event.dart';
import 'package:shopping_app/bloc/cart_bloc/cart_state.dart';
import 'package:shopping_app/bloc/order_bloc/order_bloc.dart';
import 'package:shopping_app/bloc/order_bloc/order_event.dart';
import 'package:shopping_app/constant/order_status.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/cart_model.dart';
import 'package:shopping_app/model/order_model.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/screen/user_module/product_details.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirestoreService service = FirestoreService();
  List<CartModel> carts = [];
  String? userId;
  String? userEmail;
  double totalAmount = 0.0;
  // int count = 1;
  @override
  void initState() {
    // getData();
    context.read<CartBloc>().add(GetCart());
    getCurrentUserID();
    getUserEmail();
    super.initState();
  }

  // Future<void> getData() async {
  //   final ct = await service.getCart();

  //   setState(() {
  //     carts = ct;
  //   });
  // }

  Future<void> getUserEmail() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userEmail = prefs.getString("email");
      print("Email is $userEmail");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getCurrentUserID() async {
    userId = await FirebaseAuth.instance.currentUser!.uid;
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    // double totalAmount = carts.fold(
    //   0.0,
    //   (prev, current) => prev + current.count * current.price,
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("MyCart"),
        actions: [
          IconButton(
            onPressed: () async {
              // await service.removeCart();
              // getData();
              context.read<CartBloc>().add(RemoveCart());
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CartError) {
                return Center(child: Text(state.error));
              } else if (state is CartLoaded) {
                carts = state.carts;
                totalAmount = state.carts.fold(
                  0.0,
                  (prev, current) => prev + current.count * current.price,
                );
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.carts.length,
                    itemBuilder: (context, index) {
                      final cart = state.carts[index];
                      // count = cart.count;
                      return GestureDetector(
                        onTap: () {
                          final data = ProductModel(
                            id: "",
                            name: cart.name,
                            imgUrl: cart.imgUrl,
                            categoryId: cart.categoryId,
                            price: cart.price,
                            description: cart.description,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(product: data),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(cart.imgUrl, height: 80),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(cart.name),
                                        SizedBox(width: 130),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                RemoveCartById(cart.id ?? ""),
                                              );
                                              // service.removeCartById(
                                              //   cart.id ?? '',
                                              // );
                                              // getData();
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(cart.description),
                                    Row(
                                      children: [
                                        Text(
                                          "Rs. ${cart.count * cart.price}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 40),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              child: IconButton(
                                                onPressed: () {
                                                  // if (count > 0) {
                                                  //   setState(() {
                                                  //     count--;
                                                  //   });
                                                  // }
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            // Text("$count"),
                                            Text("${cart.count}"),
                                            SizedBox(width: 20),
                                            CircleAvatar(
                                              child: IconButton(
                                                onPressed: () {
                                                  // if (count < 10) {
                                                  //   setState(() {
                                                  //     count++;
                                                  //   });
                                                  // }
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          Container(
            margin: EdgeInsets.all(12),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Total Amount: Rs. $totalAmount",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          // SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final order = OrderModel(
                id: '',
                userId: "$userId",
                email: "$userEmail",
                totalAmount: totalAmount,
                status: OrderStatus.pending,
                createdDate: DateTime.now(),
                items: carts,
              );
              context.read<OrderBloc>().add(AddOrder(order));
              context.read<CartBloc>().add(RemoveCart());
              // await service.addOrder(order);
              // await service.removeCart();
              Navigator.pop(context);
            },
            child: Text("Order", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
