class Product {
  final String image;
  final String title;
  final String subtitle;

  Product({required this.image, required this.title, required this.subtitle});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}
