import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FaviouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FaviouriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final isFavouriteMeal = state.contains(meal);
    if (isFavouriteMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FaviouriteMealsNotifier, List<Meal>>((ref) {
  return FaviouriteMealsNotifier();
});
