
import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/meal_api.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import 'detail_screen.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RecipeModel> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = MealApi().fetchMealsByLetter('a');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meal Planner',
              style: AppTextStyles.heading
            ),
            Text(
              'Find Your Next Favorite Meal',
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
                  child: Column(
                    children: [
                      _searchField(),
                      const SizedBox(height: 20),

                      Expanded(
                        child: _recipeSection()
                      )
                    ],
                  )
                ),
                const SizedBox(width: 15),
              ],
            )
          ),
          const SizedBox(height: 8),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }



  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          if (value.trim().isEmpty) {
            setState(() {
              // Kembali ke data awal
              futureRecipes =
                  MealApi().fetchMealsByLetter('a');
            });
          }
        },
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            setState(() {
              futureRecipes =
                  MealApi().fetchMealsBySearch(value);
            });
          }
        },
        
        style: AppTextStyles.body,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search recipes...',
          hintStyle: AppTextStyles.subtitle.copyWith(
            color: Colors.grey,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _recipeSection() {
    return FutureBuilder<RecipeModel>(
      future: futureRecipes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: AppTextStyles.body,
            ),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.meals == null ||
            snapshot.data!.meals!.isEmpty) {
          return Center(
            child: Text(
              'Recipe is not available',
              style: AppTextStyles.body,
            ),
          );
        }

        final meals = snapshot.data!.meals!;

        return SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < meals.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: _recipeCard(
                          meal: meals[i],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: i + 1 < meals.length
                            ? _recipeCard(
                                meal: meals[i + 1],
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _recipeCard({required Meals meal}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              mealId: meal.idMeal!, // nanti buat detail
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.strMealThumb ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Container(
              color: AppColors.recipeCard,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.strMeal ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    meal.strCategory ?? '-',
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
