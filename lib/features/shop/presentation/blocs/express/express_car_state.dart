import '../../../domain/entities/product.dart';

class ExpressCarState {
  final List<Product> products;

  const ExpressCarState({this.products = const []});

  double get total => products.fold(0, (sum, p) => sum + p.price);
}