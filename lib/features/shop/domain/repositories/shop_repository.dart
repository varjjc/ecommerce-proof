import '../entities/category.dart';
import '../entities/product.dart';

abstract class ShopRepository {
  Future<List<Category>> getCategories();
  Future<List<Product>> getProductsByCategory(String categoryName);
}