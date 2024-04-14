class MenuModel {
  final String image;
  final String name;
  final String price;

  MenuModel({
    required this.image,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> fromJson() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'price': price,
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> map) {
    return MenuModel(
      image: map['image'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
    );
  }
}
