import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key,
    required this.category,
    required this.onScreenWidget,
  });
  final Category category;
  final void Function() onScreenWidget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onScreenWidget,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
              colors: [
                category.color.withOpacity(.55),
                category.color.withOpacity(.90),
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

          ),
        ),
        child: Text(category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color : Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}

