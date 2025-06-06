import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_categories.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final GetCategories getCategories;

  CategoryBloc(this.getCategories) : super(CategoryInitial()){
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try{
        final cats = await getCategories();
        emit(CategoryLoaded(cats));
      } catch (e){
        emit(CategoryError(e.toString()));
      }
    });
  }
}