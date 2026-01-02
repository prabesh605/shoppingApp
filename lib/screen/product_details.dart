import 'package:flutter/material.dart';
import 'package:shopping_app/firebase/firestore_service.dart';
import 'package:shopping_app/model/cart_model.dart';
import 'package:shopping_app/model/product_model.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  FirestoreService service = FirestoreService();
  int count = 1;
  double total = 0;
  void increment() {
    if (count < 10) {
      setState(() {
        count++;
        total = widget.product.price * count;
      });
    }
  }

  void decrement() {
    if (count > 1) {
      setState(() {
        count--;
        total = widget.product.price * count;
      });
    }
  }

  @override
  void initState() {
    total = widget.product.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.product.name} Details")),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,

              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(widget.product.imgUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // Text("Rs.${widget.product.price}"),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs.${widget.product.price}",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          decrement();
                        },
                        icon: Icon(Icons.remove),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        "$count",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          increment();
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            Text("Description", style: TextStyle(fontSize: 22)),
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: Text(widget.product.description),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red),
              ),
              child: Text("Total Amount: Rs.$total"),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  final data = CartModel(
                    categoryId: widget.product.categoryId,
                    count: count,

                    userId: "prabesh1",
                    name: widget.product.name,
                    imgUrl: widget.product.imgUrl,
                    price: widget.product.price,
                    description: widget.product.description,
                  );
                  service.addToCart(data);
                  Navigator.pop(context);
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
