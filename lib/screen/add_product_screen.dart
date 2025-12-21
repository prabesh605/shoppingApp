import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("Add"),
      ),
      body: Center(
        child: Text("Add Product Screen"),
      ),
    );
  }
}
