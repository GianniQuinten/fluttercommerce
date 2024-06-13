class CartItem {
  final String id;
  final String shoeId; // Reference to the Shoe model
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.shoeId,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;
}
