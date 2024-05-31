import 'package:flutter/material.dart';
import '../models/shoe_model.dart';
import '../services/sneaks_api_service.dart';

class ShoeProvider with ChangeNotifier {
  final SneaksApiService apiService;

  ShoeProvider({SneaksApiService? apiService})
      : apiService = apiService ?? SneaksApiService();

  List<Shoe> _shoes = [];
  bool _isLoading = false;
  Shoe? _selectedShoe;

  List<Shoe> get shoes => _shoes;
  bool get isLoading => _isLoading;
  Shoe? get selectedShoe => _selectedShoe;

  Future<void> fetchShoes(String keyword, int limit) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await apiService.fetchProducts(keyword, limit);
      print('Full API Response: $data'); // Print the full response
      _shoes = data.map((json) => Shoe.fromJson(json)).toList();
      for (var shoe in _shoes) {
        print('Image URL: ${shoe.imageUrl}'); // Print each image URL
      }
    } catch (e) {
      // Handle error
      print('Error fetching shoes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchShoeDetails(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await apiService.fetchProductDetails(id);
      _selectedShoe = Shoe.fromJson(data);
    } catch (e) {
      // Handle error
      print('Error fetching shoe details: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
