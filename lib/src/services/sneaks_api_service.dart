import 'dart:convert';
import 'package:http/http.dart' as http;

class SneaksApiService {
  static const baseUrl = 'http://localhost:4000';

  Future<List<dynamic>> fetchProducts(String keyword, int limit) async {
    final response = await http.get(Uri.parse('$baseUrl/search/$keyword?count=$limit'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/id/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
