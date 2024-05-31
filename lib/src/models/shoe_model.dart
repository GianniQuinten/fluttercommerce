class Shoe {
  final String id;
  final String name;
  final String brand;
  final String imageUrl; // Ensure this field matches the source of the image
  final double price;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['_id'] ?? '',
      name: json['shoeName'] ?? '',
      brand: json['brand'] ?? '',
      imageUrl: json['thumbnail'] ?? '', // Ensure this uses the 'thumbnail' field
      price: (json['retailPrice'] ?? 0).toDouble(),
    );
  }
}
