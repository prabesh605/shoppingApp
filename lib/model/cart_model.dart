class CartModel {
  final String? id;
  final String name;
  final String imgUrl;
  final String categoryId;
  final double price;
  final String description;
  final int count;

  final String userId; 
  CartModel({
    this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.count,

    required this.userId,
  });
  factory CartModel.fromJson(Map<String, dynamic> json, {required String id}) {
    return CartModel(
      id: id,

      categoryId: json['categoryId'],
      count: json['count'],

      userId: json['userId'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      price: json['price'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    "name": name,
    "imgUrl": imgUrl,
    'categoryId': categoryId,
    "price": price,
    "description": description,

    'count': count,

    'userId': userId,
  };
}
