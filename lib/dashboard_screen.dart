import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping")),
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
                  SizedBox(
                    height: 700,
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: [
                        CustomContainer(
                          name: 'Shirt',
                          url: 'assets/one.jpg',
                          price: '500',
                        ),
                        CustomContainer(
                          name: 'Shirt',
                          url: 'assets/one.jpg',
                          price: '500',
                        ),
                        CustomContainer(
                          name: 'Shirt',
                          url: 'assets/one.jpg',
                          price: '500',
                        ),
                        CustomContainer(
                          name: 'Shirt',
                          url: 'assets/one.jpg',
                          price: '500',
                        ),
                        CustomContainer(
                          name: 'Shirt',
                          url: 'assets/one.jpg',
                          price: '500',
                        ),
                      ],
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
