import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/category_model.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/screen/admin_module/add_category_screen.dart';
import 'package:shopping_app/screen/admin_module/add_product_screen.dart';
import 'package:shopping_app/screen/login_screen.dart';
import 'package:shopping_app/screen/manage_order_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  FirestoreService service = FirestoreService();

  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  Future<void> getProducts() async {
    final prod = await service.getProduct();
    setState(() {
      products = prod;
      // filterProduct = prod;
    });
  }

  Future<void> getCategories() async {
    final ct = await service.getCategory();
    setState(() {
      categories = ct;
    });
  }

  @override
  void initState() {
    getProducts();
    getCategories();
    super.initState();
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    clear();
  }

  Future<void> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.admin_panel_settings),
        automaticallyImplyLeading: false,
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text("Welcome to the Admin Dashboard"),
            SizedBox(height: 20),

            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 100,
                          width: 180,
                          child: Image.network(
                            product.imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(product.name),
                        Text("${product.price}"),
                        Text(product.description),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );
              },
              child: Text(
                "Manage Products",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                );
              },
              child: Text(
                "Manage Categories",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageOrderScreen()),
                );
              },
              child: Text("Orders", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
