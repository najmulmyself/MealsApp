import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_items.dart';

import '../models/category.dart';
import '../models/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.onToggleFavorite, required this.availableMeals});

    final void Function(Meal meal) onToggleFavorite;
      final List<Meal> availableMeals;

  // Function to handle when a category is selected
  void _selectCategory(BuildContext context, Category category) {
    // Filter meals based on the selected category
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigate to the MealsScreen with filtered meals
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Show 2 columns in the grid
        childAspectRatio: 3 / 2, // Aspect ratio for items
        crossAxisSpacing: 20, // Spacing between columns
        mainAxisSpacing: 20, // Spacing between rows
      ),
      children: [
        // Create a CategoryGridItem for each available category
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            // Set the category selection callback
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
