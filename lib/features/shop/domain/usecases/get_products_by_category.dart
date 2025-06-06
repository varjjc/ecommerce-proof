import '../entities/product.dart';
import '../repositories/shop_repository.dart';

class GetProductsByCategory {
  final ShopRepository repository;

  GetProductsByCategory(this.repository);

  Future<List<Product>> call(String categoryName) {
    return repository.getProductsByCategory(categoryName);
  }
}
