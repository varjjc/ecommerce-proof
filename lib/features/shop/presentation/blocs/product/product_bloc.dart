import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products_by_category.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsByCategory getProductsByCategory;

  ProductBloc(this.getProductsByCategory) : super(ProductInitial()) {
    on<LoadProductsByCategory>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProductsByCategory(event.categoryName);
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
