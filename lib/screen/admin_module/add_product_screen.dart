import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/category_bloc/category_bloc.dart';
import 'package:shopping_app/bloc/category_bloc/category_event.dart';
import 'package:shopping_app/bloc/category_bloc/category_state.dart';
import 'package:shopping_app/bloc/product_bloc/product_bloc.dart';
import 'package:shopping_app/bloc/product_bloc/product_event.dart';
import 'package:shopping_app/bloc/product_bloc/product_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/category_model.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/service/upload_image.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final FirestoreService service = FirestoreService();
  final UploadService uploadService = UploadService();
  // List<CategoryModel> categories = [];
  // List<ProductModel> products = [];
  CategoryModel? selectedCategory;
  @override
  void initState() {
    context.read<CategoryBloc>().add(GetCategory());
    context.read<ProductBloc>().add(GetProduct());
    // getCategories();
    // getProducts();
    super.initState();
  }

  // Future<void> getCategories() async {
  //   final cat = await service.getCategory();
  //   setState(() {
  //     categories = cat;
  //     selectedCategory == cat.first;
  //   });
  // }

  // Future<void> getProducts() async {
  //   final prod = await service.getProduct();
  //   setState(() {
  //     products = prod;
  //   });
  // }

  void showAddProductBottomSheet() {
    final nameController = TextEditingController();
    final imgController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Product",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: imgController,
                        decoration: InputDecoration(
                          label: Text("imgUrl"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Image is required';
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final data = await uploadService.pickImage();
                        print("Response: $data");
                        imgController.text = data ?? "";
                      },
                      child: Text("Upload"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // TextFormField(
                //   decoration: InputDecoration(
                //     label: Text("Category"),
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return DropdownButtonFormField<CategoryModel>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        // initialValue: selectedCategory,
                        value: selectedCategory,
                        items: state.categories.map((category) {
                          return DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (CategoryModel? value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    label: Text("Price"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price is required";
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final name = nameController.text;
                      final imgUrl = imgController.text;
                      final categoryId = selectedCategory?.id ?? "";
                      final price = priceController.text;
                      final description = descriptionController.text;
                      final data = ProductModel(
                        id: "",
                        name: name,
                        imgUrl: imgUrl,
                        categoryId: categoryId,
                        price: double.parse(price),
                        description: description,
                      );
                      context.read<ProductBloc>().add(AddProduct(data));
                      // service.addProduct(data);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add Product"),
                ),
                SizedBox(height: 20),
                // Text("add Product"), SizedBox(height: 100)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddProductBottomSheet();
        },
        child: Text("Add"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text("Error"));
          } else if (state is ProductLoaded) {
            return GridView.builder(
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Container(
                  child: Column(
                    children: [
                      Image.network(product.imgUrl, height: 100),
                      Text(product.name),
                      Text("${product.price}"),
                      Text(product.description),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
