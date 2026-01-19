import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/category_bloc/category_bloc.dart';
import 'package:shopping_app/bloc/category_bloc/category_event.dart';
import 'package:shopping_app/bloc/category_bloc/category_state.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/category_model.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  FirestoreService service = FirestoreService();
  // List<CategoryModel> categories = [];

  @override
  void initState() {
    // getCategories();
    context.read<CategoryBloc>().add(GetCategory());
    super.initState();
  }

  // Future<void> getCategories() async {
  //   final cat = await service.getCategory();
  //   setState(() {
  //     categories = cat;
  //   });
  // }

  void showAddProductBottonSheet(context) {
    final nameController = TextEditingController();
    final imageUrlController = TextEditingController();
    // final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  final name = nameController.text;
                  final imageUrl = imageUrlController.text;
                  print("name: $name, imageUrl: $imageUrl");
                  final data = CategoryModel(
                    id: "",
                    name: name,
                    imgUrl: imageUrl,
                  );
                  if (name.isEmpty || imageUrl.isEmpty) {
                    print("Enter data");
                  } else {
                    context.read<CategoryBloc>().add(AddCategory(data));
                    // service.addCategory(data);
                  }
                  Navigator.pop(context);
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddProductBottonSheet(context);
        },
        child: Text("Add"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CategoryError) {
            return Center(child: Text("Error"));
          }
          if (state is CategoryLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final datas = state.categories[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Image.network(datas.imgUrl, height: 90),
                      Text(datas.name),
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
