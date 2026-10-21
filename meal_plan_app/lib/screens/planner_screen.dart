
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../data/recipe_data.dart';
import '../theme.dart';
import 'detail_screen.dart';

class PlannedRecipe {
  final String recipeId;
  String day;

  PlannedRecipe({
    required this.recipeId,
    required this.day,
  });
}

class PlannerScreen extends StatefulWidget {
  final List<PlannedRecipe> plannedRecipes;

  const PlannerScreen({
    super.key,
    required this.plannedRecipes,
  });

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  RecipeData? _findRecipe(String id) {
    for (final recipe in recipeDatas) {
      if (recipe.id == id) {
        return recipe;
      }
    }

    return null;
  }

  // Menampilkan dialog untuk memindahkan resep ke hari lain.
  void _editRecipe(PlannedRecipe plannedRecipe) {
    String selectedDay = plannedRecipe.day;

    showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.background,
              title: Text(
                'Edit Planner',
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 20,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Move to another day:',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedDay,
                    isExpanded: true,
                    dropdownColor: AppColors.background,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
                ],
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
    ).then((newDay) {
      if (newDay == null || !mounted) return;

      setState(() {
        plannedRecipe.day = newDay;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Move to $newDay'),
        ),
      );
    });
  }

  // hapus planner
  void _removeRecipe(PlannedRecipe plannedRecipe) {
    setState(() {
      widget.plannedRecipes.remove(plannedRecipe);
    });
  }

  // kartu per hari
  Widget _dayCard(String day) {
    final recipesForDay = widget.plannedRecipes
        .where((item) => item.day == day)
        .toList();

    return Card(
      color: AppColors.recipeCard,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        // initiallyExpanded: day == 'Monday',
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFD5F0E8),
          child: Icon(
            Icons.calendar_month,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          day,
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${recipesForDay.length} recipes',
          style: AppTextStyles.subtitle,
        ),
        children: [
          if (recipesForDay.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Your meal plan is empty for today',
                style: AppTextStyles.body,
              ),
            )
          else
            for (final plannedRecipe in recipesForDay)
              _recipeItem(plannedRecipe),
        ],
      ),
    );
  }

  // card resep
  Widget _recipeItem(PlannedRecipe plannedRecipe) {
    final meal = _findRecipe(plannedRecipe.recipeId);

    if (meal == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailScreen(
              mealId: meal.id
            ), 
          ),
        );
      },

      borderRadius: BorderRadius.circular(12),

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              meal.image,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 68,
                  height: 68,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.restaurant),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              meal.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (action) {
              if (action == 'edit') {
                _editRecipe(plannedRecipe);
              } else if (action == 'delete') {
                _removeRecipe(plannedRecipe);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Your Week',
              style: AppTextStyles.heading.copyWith(
                fontSize: 23
              ),
            ),
            Text(
              'Stay healthy, stay organized!',
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryLight,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: ListView(
                    children: [
                      for (final day in days) _dayCard(day),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
