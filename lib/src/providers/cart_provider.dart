import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String shoeId, String name, String brand, String imageUrl, double price) {
    if (_items.containsKey(shoeId)) {
      // Update quantity if item already exists in cart
      _items.update(
        shoeId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          shoeId: existingCartItem.shoeId,
          name: existingCartItem.name,
          brand: existingCartItem.brand,
          imageUrl: existingCartItem.imageUrl,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // Add new item to cart
      _items.putIfAbsent(
        shoeId,
            () => CartItem(
          id: DateTime.now().toString(),
          shoeId: shoeId,
          name: name,
          brand: brand,
          imageUrl: imageUrl,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String shoeId) {
    _items.remove(shoeId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void updateItemQuantity(String shoeId, int newQuantity) {
    if (_items.containsKey(shoeId)) {
      if (newQuantity <= 0) {
        removeItem(shoeId);
      } else {
        _items.update(
          shoeId,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            shoeId: existingCartItem.shoeId,
            name: existingCartItem.name,
            brand: existingCartItem.brand,
            imageUrl: existingCartItem.imageUrl,
            price: existingCartItem.price,
            quantity: newQuantity,
          ),
        );
      }
      notifyListeners();
    }
  }
}
