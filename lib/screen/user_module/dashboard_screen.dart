import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/category_model.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/screen/admin_module/admin_dashboard.dart';
import 'package:shopping_app/screen/user_module/cart_screen.dart';
import 'package:shopping_app/screen/login_screen.dart';
import 'package:shopping_app/screen/user_module/product_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.role});
  final String role;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSelected = true;
  FirestoreService service = FirestoreService();

  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  List<ProductModel> filterProduct = [];
  String selectedCategory = '';

  Future<void> getProducts() async {
    final prod = await service.getProduct();
    setState(() {
      products = prod;
      filterProduct = prod;
    });
  }

  Future<void> getCategories() async {
    final ct = await service.getCategory();
    setState(() {
      categories = ct;
    });
  }

  void filterProductByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category.isEmpty) {
        filterProduct = products;
      } else {
        filterProduct = products
            .where((product) => product.categoryId == category)
            .toList();
      }
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
      backgroundColor: Colors.blue.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        title: Text("Shopping"),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person),
          ),

          // IconButton(
          //   onPressed: () {
          //     logout();
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(builder: (context) => LoginScreen()),
          //     );
          //   },
          //   icon: Icon(Icons.logout),
          // ),
          // Visibility(
          //   visible: widget.role == 'admin' ? false : true,
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => AdminDashboard()),
          //       );
          //     },
          //     icon: Icon(Icons.admin_panel_settings),
          //   ),
          // ),
          SizedBox(width: 20),
          Visibility(
            visible: widget.role == 'admin' ? true : false,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminDashboard()),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset("assets/shopLogo.png")),
            Expanded(
              child: Column(
                children: [
                  ListTile(leading: Icon(Icons.home), title: Text("Home")),
                  ListTile(leading: Icon(Icons.person), title: Text("Profile")),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                  ),
                  ListTile(
                    onTap: () {
                      logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            filterProductByCategory(category.id);
                          },
                          child: TrendingWidget(
                            isSelected: false,
                            name: category.name,
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: 1000,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       TrendingWidget(
                  //         isSelected: isSelected,
                  //         name: "Trending",
                  //       ),
                  //       SizedBox(width: 10),
                  //       TrendingWidget(isSelected: false, name: "Shoes"),
                  //       SizedBox(width: 10),
                  //       TrendingWidget(isSelected: false, name: "SweatShirts"),
                  //       SizedBox(width: 10),
                  //       TrendingWidget(isSelected: false, name: "Shirts"),
                  //       SizedBox(width: 10),
                  //       TrendingWidget(isSelected: false, name: "Bags"),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 1000,
                    child: GridView.builder(
                      itemCount: filterProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemBuilder: (context, index) {
                        final product = filterProduct[index];
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
          width: 150,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            // border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(url, fit: BoxFit.contain),
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
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.blueAccent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
      ),
      child: Text(
        name,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white),
      ),
    );
  }
}
