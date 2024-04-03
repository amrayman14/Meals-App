import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widget/category_grid_item.dart';
import 'package:meal_app/models/category.dart';

import '../models/meal.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.filteredMeals});

  final List<Meal> filteredMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;

  @override
  void initState(){
    super.initState();
  _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    upperBound: 1,
    lowerBound: 0,
  );
    _animationController.forward();
  }

  @override
  void dispose(){
    super.dispose();
  _animationController.dispose();
  }

  _selectScreen(BuildContext context, Category category) {
final availableMeals = widget.filteredMeals.where((meal) =>
  meal.categories.contains(category.id)).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
            meals: availableMeals
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        builder: (context , child) => SlideTransition(
          position: Tween(
                begin: const Offset( 0 , 0.3 ),
                end: const Offset( 0 , 0 )
              ).animate(
                  CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInOut),

            ),
          child: child
        )
    );

  }
}
