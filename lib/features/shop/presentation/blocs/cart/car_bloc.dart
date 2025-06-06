import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import 'car_event.dart';
import 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(const CarState()) {
    on<AddProductToCar>((event, emit) {
      final updatedList = List<Product>.from(state.products)..add(event.product);
      emit(CarState(products: updatedList));
    });

    on<RemoveProductFromCar>((event, emit) {
      final updatedList = List<Product>.from(state.products)
        ..remove(event.product);
      emit(CarState(products: updatedList));
    });

    on<ClearCar>((event, emit) {
      emit(const CarState());
    });
  }
}
