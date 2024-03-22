import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widget/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreen();
  }
}

Map<Filters, bool> kInitializedFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class _TabsScreen extends State<TabsScreen> {
  int _currentPageIndex = 0;
  Map<Filters, bool> _selectedFilters = kInitializedFilters;

  final List<Meal> _favoriteMeals = [];

  void _toggleFavoriteMeal(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showMessage('This meal is no longer exist');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showMessage('Saved to Favorites');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final returnFilters =
          await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            filters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = returnFilters ?? kInitializedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activeScreen = CategoriesScreen(
      toggleFavoritesScreen: _toggleFavoriteMeal,
      filteredMeals: filteredMeals,
    );
    var activeTitle = "Categories";

    if (_currentPageIndex == 1) {
      activeTitle = "Your Favorite";
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        toggleFavoritesScreen: _toggleFavoriteMeal,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
