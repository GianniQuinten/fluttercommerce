import 'package:flutter/material.dart';
import '../models/shoe_model.dart';
import '../services/sneaks_api_service.dart';

class ShoeProvider with ChangeNotifier {
  final SneaksApiService apiService;

  ShoeProvider({SneaksApiService? apiService})
      : apiService = apiService ?? SneaksApiService();

  List<Shoe> _shoes = [];
  List<Shoe> _filteredShoes = [];
  bool _isLoading = false;
  Shoe? _selectedShoe;
  String _currentKeyword = "";
  int _currentLimit = 20;

  List<Shoe> get shoes => _filteredShoes;
  bool get isLoading => _isLoading;
  Shoe? get selectedShoe => _selectedShoe;

  Future<void> fetchShoes(String keyword, int limit) async {
    _isLoading = true;
    _currentKeyword = keyword;
    _currentLimit = limit;
    notifyListeners();

    keyword = keyword + " Shoe"; // Make it so the search query always is a Shoe

    try {
      final data = await apiService.fetchProducts(keyword, limit);
      _shoes = data.map((json) => Shoe.fromJson(json)).toList();
      _filteredShoes = _shoes;
    } catch (e) {
      // Handle error
      print('Error fetching shoes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterShoes({String? brand}) {
    // Update the current keyword based on the brand filter
    _currentKeyword = brand ?? _currentKeyword;

    // Perform the filtering
    _filteredShoes = _shoes.where((shoe) {
      final matchesBrand = brand == null || shoe.brand.toLowerCase().contains(brand.toLowerCase());
      return matchesBrand;
    }).toList();

    // Fetch shoes with the updated keyword
    fetchShoes(_currentKeyword, _currentLimit);

    notifyListeners();
  }

  Future<void> reloadShoes({String keyword = ""}) async {
    _currentKeyword = keyword;
    await fetchShoes(_currentKeyword, _currentLimit);
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
