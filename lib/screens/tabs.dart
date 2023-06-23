import 'package:flutter/material.dart';
import 'package:meal_app/data/category_data.dart';
import 'package:meal_app/enum/filter.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInitalFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favourite = [];
  Map<Filter, bool> _selectedFilters = kInitalFilters;
  void _showInfoMessage(String messange) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messange),
      ),
    );
  }

  void _toogleMealFavouriteStatus(Meal meal) {
    final isExisting = _favourite.contains(meal);
    isExisting == true
        ? {
            setState(
              () => _favourite.remove(meal),
            ),
            _showInfoMessage('Meal is no longer a favourtite')
          }
        : {
            setState(() => _favourite.add(meal)),
            _showInfoMessage('Marked as a favourite!')
          };
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifers) async {
    Navigator.of(context).pop();
    if (identifers == 'filter') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilter: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitalFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var availableMeals = dummyMeals.where((meals) {
      if (_selectedFilters[Filter.glutenFree]! && !meals.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meals.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meals.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meals.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = Catergories(
      onToggleFavourite: _toogleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Catergories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favourite,
        onToggleFavourite: _toogleMealFavouriteStatus,
      );
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Catergories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
        ],
      ),
    );
  }
}
