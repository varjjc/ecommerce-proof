import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/product_model.dart';

class ShopApiService {
  final http.Client client;

  ShopApiService(this.client);

Future<List<CategoryModel>> fetchCategories() async {
  final response = await client.get(Uri.parse("https://fakestoreapi.com/products/categories"));
  
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data
        .asMap()
        .entries
        .map((entry) => CategoryModel.fromString(entry.value, entry.key))
        .toList();
  } else {
    throw Exception('Error al cargar categorías');
  }
}

Future<List<ProductModel>> fetchProductsByCategory(String categoryName) async {
  final url = Uri.parse('https://fakestoreapi.com/products/category/$categoryName');

  final response = await client.get(url);

  if (response.statusCode == 200) {
    final List data = json.decode(response.body);

    return data.map((e) => ProductModel.fromJson(e)).toList();
  } else {
    throw Exception('Error al cargar productos');
  }
}


}