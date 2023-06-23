import 'package:meal_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/data/category_data.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/models/meal.dart';

class Catergories extends StatelessWidget {
  const Catergories({
    super.key,
    required this.onToggleFavourite,
    required this.availableMeals,
  });
  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();
    //Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...availableCategories.map(
          (category) => CatergoryGridItem(
            category: category,
            onSelectItem: () => _selectCategory(context, category),
          ),
        ),
        // for (var category in availableCategories)
        //   CatergoryGridItem(
        //     category: category,
        //   ),
      ],
    );
  }
}
