import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/enum/filter.dart';
import 'package:meal_app/providers/meals_provider.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> choosenFiler) {
    state = choosenFiler;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);
final filteredMealsProvider = Provider((ref) {
  final meal = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meal.where((meals) {
    if (activeFilters[Filter.glutenFree]! && !meals.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meals.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meals.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meals.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
