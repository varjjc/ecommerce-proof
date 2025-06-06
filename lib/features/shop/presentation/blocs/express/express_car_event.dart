import '../../../domain/entities/product.dart';

abstract class ExpressCarEvent {}

class AddProductToExpressCar extends ExpressCarEvent {
  final Product product;
  AddProductToExpressCar(this.product);
}

class RemoveProductFromExpressCar extends ExpressCarEvent {
  final Product product;
  RemoveProductFromExpressCar(this.product);
}

class ClearExpressCart extends ExpressCarEvent {}