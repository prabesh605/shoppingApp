class ProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String categoryId;
  final double price;
  final String description;
  ProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.categoryId,
    required this.price,
    required this.description,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        imgUrl: json['imgUrl'],
        categoryId: json['categoryId'],
        price: json['price'],
        description: json['description']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'categoryId': categoryId,
      'price': price,
      'description': description,
    };
  }
}
