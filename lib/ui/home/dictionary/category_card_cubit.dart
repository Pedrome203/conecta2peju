import 'package:conecta2peju/domain/models/card_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCardState {
  const CategoryCardState(this.categoryCard);
  final CategoryCard? categoryCard;
}

class CategoryCardCubit extends Cubit<List<CategoryCardState>> {
  CategoryCardCubit() : super([]);

  void init() async {
    final catalog = (listCategory).map((e) => CategoryCardState(e));
    emit(catalog.toList());
  }
}
