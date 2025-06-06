import '../../domain/entities/category.dart';

class CategoryModel extends Category {

CategoryModel({required int id, required String name})
    : super(id: id, name: name);


factory CategoryModel.fromString(String name, int id) {
  return CategoryModel(id: id, name: name);
}

}