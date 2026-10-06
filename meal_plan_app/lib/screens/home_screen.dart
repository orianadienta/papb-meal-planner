import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/meal_api.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late Future<RecipeModel> futureRecipes;

  @override
  void initState() { //untuk mengambil data saat halaman dibuka
    super.initState();
    futureRecipes = MealApi().fetchMealsByLetter('a');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1DBE8),
      
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discover',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF43302E),
              ),
            ),

            Text(
              'Find Your Next Favorite Meal',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF43302E),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFC1DBE8),
        elevation: 0.0,
     ),

      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          SizedBox(height: 20),

          Expanded(
            child: _recipeSection(),
              // SizedBox(height: 20)
          )
          

          // Column(
          //  children: [
          //   Row(
              
          //   )
          //  ]
              
          // )
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  Container _searchField() {
    return Container(
          margin: EdgeInsets.only(top:20, left:20, right:20),
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
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  futureRecipes = MealApi().fetchMealsBySearch(value);
                });
              }
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search recipes...',
              hintStyle: TextStyle(
                color: Colors.grey
              ),

              prefixIcon: Icon(
                Icons.search, 
                color: Colors.grey
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15), 
                borderSide: BorderSide.none,
               ),
            ),
          )
        );
  }

  Widget _recipeSection() {
    return FutureBuilder<RecipeModel>(
      future: futureRecipes,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.meals == null ||
            snapshot.data!.meals!.isEmpty) {
          return Center(
            child: Text('Tidak ada resep'),
          );
        }

        final meals = snapshot.data!.meals!;

        return SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < meals.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
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
    return Card(
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
            color: Color.fromARGB(255, 236, 228, 177),
            width: double.infinity,

            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF43302E)
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  meal.strCategory ?? '-',
                  style: TextStyle(
                    color: Color.fromARGB(255, 93, 68, 65),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}