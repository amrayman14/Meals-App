import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widget/category_grid_item.dart';
import 'package:meal_app/models/category.dart';

import '../models/meal.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.toggleFavoritesScreen, required this.filteredMeals});

  final void Function(Meal meal) toggleFavoritesScreen;
  final List<Meal> filteredMeals;

  _selectScreen(BuildContext context, Category category) {
final avalableMeals = filteredMeals.where((meal) =>
  meal.categories.contains(category.id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          toggleFavoritesScreen: toggleFavoritesScreen,
            meals: avalableMeals
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.5,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onScreenWidget: (){
                _selectScreen(context,category);
              },
            )
        ],
      ),
    );
  }
}
