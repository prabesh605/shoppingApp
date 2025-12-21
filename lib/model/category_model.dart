class CategoryModel {
  final String id;
  final String name;
  final String imgUrl;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imgUrl,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'], name: json['name'], imgUrl: json['imgUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
    };
  }
}
