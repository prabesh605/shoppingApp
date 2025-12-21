import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  void showAddProductBottonSheet(context) {
    final nameController = TextEditingController();
    final imageUrlController = TextEditingController();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add New Category"),
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Category Name",
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Category Image Url",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    final name = nameController.text;
                    final imageUrl = imageUrlController.text;
                    print("name: $name, imageUrl: $imageUrl");
                  },
                  child: Text(
                    "Add Category",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddProductBottonSheet(context);
        },
        child: Text("Add"),
      ),
      body: Center(
        child: Text("Add Category Screen"),
      ),
    );
  }
}
