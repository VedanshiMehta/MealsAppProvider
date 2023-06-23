import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details.dart';
import 'package:meal_app/widgets/empty_meal.dart';
import 'package:meal_app/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavourite,
  });
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;
  void mealDetailScreen(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meals: meal,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget onscreenWidget = const EmptyMeal();

    if (meals.isNotEmpty) {
      onscreenWidget = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, indx) => MealsItem(
          meal: meals[indx],
          onSelectMeal: (meal) => mealDetailScreen(context, meal),
        ),
      );
    }
    if (title == null) {
      return onscreenWidget;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: onscreenWidget,
    );
  }
}
