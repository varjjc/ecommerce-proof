import '../../../domain/entities/product.dart';

abstract class CarEvent {}

class AddProductToCar extends CarEvent {
  final Product product;
  AddProductToCar(this.product);
}

class RemoveProductFromCar extends CarEvent {
  final Product product;
  RemoveProductFromCar(this.product);
}

class ClearCar extends CarEvent {}