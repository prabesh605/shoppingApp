import 'package:flutter/material.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/order_model.dart';
import 'package:shopping_app/screen/admin_module/order_detail_page.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  FirestoreService service = FirestoreService();
  List<OrderModel> orders = [];
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    final ord = await service.getOrder();
    setState(() {
      orders = ord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Orders")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      // OrderDetailPage();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(orders: order),
                        ),
                      );
                    },
                    leading: Text(order.status),
                    title: Text(order.email),
                    subtitle: Text("${order.totalAmount}"),
                    trailing: Text("${order.items.length}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
