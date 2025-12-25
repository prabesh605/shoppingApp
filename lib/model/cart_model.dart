class CartModel {
  final String? id;
  final String productId;
  final String productName;
  final String categoryName;
  final String categoryId;
  final int count;
  final double totalAmount;
  final String userId;
  CartModel({
    this.id,
    required this.productId,
    required this.productName,
    required this.categoryName,
    required this.categoryId,
    required this.count,
    required this.totalAmount,
    required this.userId,
  });
  factory CartModel.fromJson(Map<String, dynamic> json, {required String id}) {
    return CartModel(
      id: id,
      productId: json['productId'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      categoryId: json['categoryId'],
      count: json['count'],
      totalAmount: json['totalAmount'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'productId': productId,
    'categoryName': categoryName,
    'categoryId': categoryId,
    'count': count,
    'totalAmount': totalAmount,
    'userId': userId,
  };
}
