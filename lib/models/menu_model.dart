class MenuModel {
  final String name;
  final String price;
  final String image;

  MenuModel({
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> map) {
    return MenuModel(
      name: map['name'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
    );
  }
}
