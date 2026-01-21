import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/order_bloc/order_bloc.dart';
import 'package:shopping_app/bloc/order_bloc/order_event.dart';
import 'package:shopping_app/bloc/order_bloc/order_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/order_model.dart';
import 'package:shopping_app/screen/admin_module/order_detail_page.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  // FirestoreService service = FirestoreService();
  // List<OrderModel> orders = [];
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetAllOrder());
    // getOrders();
  }

  // void getOrders() async {
  //   final ord = await service.getOrder();
  //   setState(() {
  //     orders = ord;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Orders")),
      body: RefreshIndicator(
        onRefresh: () {
          context.read<OrderBloc>().add(GetAllOrder());
          return Future.delayed(Duration(seconds: 4));
        },
        child: Column(
          children: [
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is OrderLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return Container(
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () async {
                              // OrderDetailPage();
                              final value = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailPage(orders: order),
                                ),
                              );
                              if (value == true) {
                                context.read<OrderBloc>().add(GetAllOrder());
                              }
                            },
                            leading: Text(order.status.name),
                            title: Text(order.email),
                            subtitle: Text("${order.totalAmount}"),
                            trailing: Text("${order.items.length}"),
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
      ),
    );
  }
}
