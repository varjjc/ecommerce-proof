import '../../../domain/entities/product.dart';

class CarState {
  final List<Product> products;

  const CarState({this.products = const []});

  double get total => products.fold(0, (sum, p) => sum + p.price);
}