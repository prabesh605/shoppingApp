import 'package:flutter/material.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/screen/admin_dashboard.dart';
import 'package:shopping_app/screen/cart_screen.dart';
import 'package:shopping_app/screen/product_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSelected = true;
  FirestoreService service = FirestoreService();
  List<ProductModel> products = [];

  Future<void> getProducts() async {
    final prod = await service.getProduct();
    setState(() {
      products = prod;
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
          SizedBox(width: 20),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminDashboard()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  label: Text("Search products"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 1000,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TrendingWidget(
                          isSelected: isSelected,
                          name: "Trending",
                        ),
                        SizedBox(width: 10),
                        TrendingWidget(isSelected: false, name: "Shoes"),
                        SizedBox(width: 10),
                        TrendingWidget(isSelected: false, name: "SweatShirts"),
                        SizedBox(width: 10),
                        TrendingWidget(isSelected: false, name: "Shirts"),
                        SizedBox(width: 10),
                        TrendingWidget(isSelected: false, name: "Bags"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 500,
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(product: product),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Image.network(product.imgUrl, height: 100),
                                Text(product.name),
                                Text("${product.price}"),
                                Text(product.description),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.name,
    required this.url,
    required this.price,
  });
  final String name;
  final String url;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            // border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(url),
        ),
        Text(name),
        Text("Rs$price"),
      ],
    );
  }
}

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({
    super.key,
    required this.isSelected,
    required this.name,
  });

  final bool isSelected;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(),
      ),
      child: Text(
        name,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
