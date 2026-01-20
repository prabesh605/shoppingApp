import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:shopping_app/bloc/order_bloc/order_bloc.dart';
import 'package:shopping_app/bloc/order_bloc/order_event.dart';
import 'package:shopping_app/bloc/order_bloc/order_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/order_model.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  // FirestoreService service = FirestoreService();
  // List<OrderModel> orders = [];
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrder());
    // getUserOrder();
  }

  // Future<void> getUserOrder() async {
  //   final ord = await service.getMyOrder();
  //   setState(() {
  //     orders = ord;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: Column(
        children: [
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrderError) {
                return Center(child: Text(state.error));
              } else if (state is OrderLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final item = state.orders[index];

                      return Container(
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue.shade100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.status,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${item.createdDate}"),
                            Text("${item.totalAmount}"),
                            Divider(),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: item.items.length,
                                itemBuilder: (context, index) {
                                  final data = item.items[index];
                                  return ListTile(
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      child: Image.network(
                                        data.imgUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      data.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text('${data.count}'),
                                    trailing: Text("${data.price}"),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
