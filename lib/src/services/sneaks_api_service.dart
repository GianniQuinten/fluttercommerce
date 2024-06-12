import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class SneaksApiService {
  static const String baseUrl = 'http://localhost:4000';
  static const String androidBaseUrl = 'http://10.0.2.2:4000';

  Future<List<dynamic>> fetchProducts(String keyword, int limit) async {
    try {
      return await _fetchProductsFromUrl(baseUrl, keyword, limit);
    } catch (e) {
      if (Platform.isAndroid) {
        return await _fetchProductsFromUrl(androidBaseUrl, keyword, limit);
      } else {
        throw Exception('Failed to load products: $e');
      }
    }
  }

  Future<List<dynamic>> _fetchProductsFromUrl(String url, String keyword, int limit) async {
    final response = await http.get(Uri.parse('$url/search/$keyword?count=$limit'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails(String id) async {
    try {
      return await _fetchProductDetailsFromUrl(baseUrl, id);
    } catch (e) {
      if (Platform.isAndroid) {
        return await _fetchProductDetailsFromUrl(androidBaseUrl, id);
      } else {
        throw Exception('Failed to load product details: $e');
      }
    }
  }

  Future<Map<String, dynamic>> _fetchProductDetailsFromUrl(String url, String id) async {
    final response = await http.get(Uri.parse('$url/id/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
