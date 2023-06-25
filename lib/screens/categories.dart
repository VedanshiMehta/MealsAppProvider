import 'package:meal_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/data/category_data.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/models/meal.dart';

class Catergories extends StatefulWidget {
  const Catergories({
    super.key,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;

  @override
  State<Catergories> createState() => _CatergoriesState();
}

class _CatergoriesState extends State<Catergories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();
    //Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOutCubic,
          ),
        ),
        child: child,
      ),
    );
  }
}
