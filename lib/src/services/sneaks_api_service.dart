import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class SneaksApiService {
  static String get baseUrl {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'http://10.0.2.2:4000'; // For both Android and iOS use 10.0.2.2
    } else {
      return 'http://localhost:4000'; // For other platforms use localhost
    }
  }

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
