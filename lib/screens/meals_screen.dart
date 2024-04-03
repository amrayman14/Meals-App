import 'package:flutter/material.dart';
import 'package:meal_app/widget/meal_item.dart';
import '../models/meal.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatelessWidget {
   const MealsScreen({
    super.key,
     this.title,
    required this.meals,
  });

  final String? title ;
  final List<Meal> meals;
  void _onSelectedMeal(Meal meal, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetailScreen(
              meal: meal,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " There is nothing here",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting different category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          selectedMeal: (meal) {
            _onSelectedMeal(meal, context);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
    );
  }
}
