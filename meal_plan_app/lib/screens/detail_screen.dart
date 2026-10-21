import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../theme.dart';
import '../data/recipe_data.dart';
import '../screens/planner_screen.dart';
import '../data/planner_data.dart';

class DetailScreen extends StatelessWidget {
  final String mealId;

  const DetailScreen({
    super.key,
    required this.mealId,
  });

  RecipeData get selectedRecipe {
    for (final recipe in recipeDatas) {
      if (recipe.id == mealId) {
        return recipe;
      }
    }

    return recipeDatas.first;
  }

  void _addToPlanner(BuildContext context, RecipeData meal) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    String selectedDay = 'Monday';

    showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.background,
              title: const Text(
                'Add to Planner',
                style: TextStyle(
                  color: AppColors.textPrimary,
                ),
              ),
              content: DropdownButton<String>(
                value: selectedDay,
                isExpanded: true,
                dropdownColor: AppColors.background,
                items: days.map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() {
                      selectedDay = value;
                    });
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, selectedDay);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: AppColors.accent,
                  ),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    ).then((day) {
      if (day == null || !context.mounted) return;

      plannedRecipes.add(
        PlannedRecipe(
          recipeId: meal.id,
          day: day,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added recipe to $day'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final meal = selectedRecipe;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      meal.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.restaurant,
                            size: 60,
                            color: AppColors.textPrimary,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // detail resep
                Transform.translate(
                  offset: const Offset(0, -25),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul resep dan tombol planner
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  meal.name,
                                  style: AppTextStyles.cardTitle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () => _addToPlanner(context, meal),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.textPrimary,
                                  foregroundColor: AppColors.accent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                label: Text(
                                  'Add to planner',
                                  style: AppTextStyles.button.copyWith(
                                    fontSize: 14,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Kategori resep
                          Text(
                            meal.category,
                            style: AppTextStyles.subtitle,
                          ),

                          const SizedBox(height: 24),

                          // Ingredients
                          Text(
                            'Ingredients',
                            style: AppTextStyles.cardTitle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          for (final ingredient in meal.ingredients)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                ingredient,
                                style: AppTextStyles.body.copyWith(
                                  height: 1.4,
                                ),
                              ),
                            ),

                          const SizedBox(height: 24),

                          // Instructions
                          Text(
                            'Instructions',
                            style: AppTextStyles.cardTitle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            meal.instructions,
                            style: AppTextStyles.body.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}