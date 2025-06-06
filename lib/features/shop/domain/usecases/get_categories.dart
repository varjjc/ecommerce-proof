import '../entities/category.dart';
import '../repositories/shop_repository.dart';

class GetCategories {
  final ShopRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call(){
    return repository.getCategories();
  }
}