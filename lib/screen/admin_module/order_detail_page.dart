import 'package:flutter/material.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/cart_model.dart';
import 'package:shopping_app/model/order_model.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.orders});
  final OrderModel orders;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  FirestoreService service = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
        actions: [
          GestureDetector(
            onTap: () {
              final order = OrderModel(
                id: widget.orders.id,
                userId: widget.orders.userId,
                email: widget.orders.email,
                totalAmount: widget.orders.totalAmount,
                status: "Complete",
                createdDate: widget.orders.createdDate,
                items: widget.orders.items,
              );
              service.updateOrder(order);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Order updated"),
                  backgroundColor: Colors.green,
                ),
              );
              // widget.orders.status;
            },
            child: Text("Update"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.orders.items.length,
        itemBuilder: (context, index) {
          final item = widget.orders.items[index];
          return Container(
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
                  Image.network(item.imgUrl, height: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(item.name)],
                      ),
                      Text(item.description),
                      Row(
                        children: [
                          Text(
                            "Rs. ${item.count * item.price}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 40),
                          Text("${item.count}"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
