import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import 'express_car_event.dart';
import 'express_car_state.dart';

class ExpressCarBloc extends Bloc<ExpressCarEvent, ExpressCarState> {
  ExpressCarBloc() : super(const ExpressCarState()) {
    on<AddProductToExpressCar>((event, emit) {
      final updatedList = List<Product>.from(state.products)..add(event.product);
      emit(ExpressCarState(products: updatedList));
    });

    on<RemoveProductFromExpressCar>((event, emit) {
      final updatedList = List<Product>.from(state.products)..remove(event.product);
      emit(ExpressCarState(products: updatedList));
    });

    on<ClearExpressCart>((event, emit) {
      emit(const ExpressCarState());
    });
  }
}
