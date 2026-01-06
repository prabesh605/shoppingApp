import 'package:flutter/material.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/order_model.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  FirestoreService service = FirestoreService();
  List<OrderModel> orders = [];
  @override
  void initState() {
    super.initState();
    getUserOrder();
  }

  Future<void> getUserOrder() async {
    final ord = await service.getMyOrder();
    setState(() {
      orders = ord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.first.items.length,
              itemBuilder: (context, index) {
                final item = orders.first.items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${item.count}"),
                        SizedBox(width: 20),
                        Text(item.name),
                      ],
                    ),

                    Text("${item.price}"),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
