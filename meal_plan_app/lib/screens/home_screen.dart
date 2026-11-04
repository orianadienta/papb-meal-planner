
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import 'detail_screen.dart';
import '../theme.dart';
import '../data/recipe_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final List<RecipeData> recipes = recipeDatas;

 String searchRecipe = '';

 List<RecipeData> get filteredRecipes {
    if (searchRecipe.trim().isEmpty) {
      return recipes;
    }

    return recipes.where((recipe) {
      return recipe.name
          .toLowerCase()
          .contains(searchRecipe.trim().toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Meal Planner',
          style: AppTextStyles.heading.copyWith(
            letterSpacing: 2,
            color: AppColors.background,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
    

      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
               color: AppColors.primary,
               borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(15, 4, 15, 16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Your Next Favorite Meal',
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                _searchField(),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      Column(
                        children: [
                          Text(
                          'Explore',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                            
                          ),
                        ),
                        const SizedBox(height: 15),
                        ],
                      ),

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
            color:Colors.black.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
              searchRecipe = value;
            });
        },
        
        style: AppTextStyles.body,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search recipes...',
          hintStyle: AppTextStyles.subtitle,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _recipeSection() {
    final meals = filteredRecipes;

    if (meals.isEmpty) {
      return Center(
        child: Text(
          'Recipe is not available',
          style: AppTextStyles.body,
        ),
      );
    }

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
  }

  Widget _recipeCard({required  RecipeData meal}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              mealId: meal.id, 
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.surface,
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              meal.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Container(
              color: AppColors.surface,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    meal.category,
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
