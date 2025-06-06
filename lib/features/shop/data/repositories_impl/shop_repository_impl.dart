import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_api_services.dart';


class ShopRepositoryImpl implements ShopRepository {
  final ShopApiService api;

  ShopRepositoryImpl(this.api);

  @override
  Future<List<Category>> getCategories(){

    return api.fetchCategories();
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryName) {
    return api.fetchProductsByCategory(categoryName);
  }
}