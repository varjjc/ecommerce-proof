abstract class ProductEvent {}

class LoadProductsByCategory extends ProductEvent{
  final String categoryName;

  LoadProductsByCategory(this.categoryName);
}