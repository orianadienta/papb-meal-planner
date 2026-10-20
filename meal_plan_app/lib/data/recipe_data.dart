
class RecipeData {
  final String id;
  final String name;
  final String category;
  final String instructions;
  final List<String> ingredients;
  final String image;

  const RecipeData({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.ingredients,
    required this.image,
  });
}

const List<RecipeData> recipeDatas = [
  RecipeData(
    id: '1',
    name: 'Papaya Salad',
    category: 'Vegetarian',
    instructions:
        '1. Kupas dan serut pepaya muda.\n'
        '2. Haluskan cabai dan bawang putih.\n'
        '3. Campurkan air jeruk nipis, gula, dan kecap ikan.\n'
        '4. Masukkan pepaya dan tomat, lalu aduk rata.\n'
        '5. Sajikan selagi segar.',
    ingredients: [
      'Green Papaya — 1/2 buah',
      'Tomato — 2 buah',
      'Lemon Juice — 1 tablespoon',
      'Garlic — 2 cloves',
      'Chili — 2 buah',
      'Sugar — 1 teaspoon',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/rlwcc51598734603.jpg',
  ),

  RecipeData(
    id: '2',
    name: 'Chicken Teriyaki',
    category: 'Chicken',
    instructions:
        '1. Potong ayam menjadi bagian kecil.\n'
        '2. Campurkan kecap asin, saus teriyaki, dan gula.\n'
        '3. Panaskan sedikit minyak di wajan.\n'
        '4. Masak ayam hingga matang, lalu masukkan saus.\n'
        '5. Aduk hingga saus mengental dan sajikan.',
    ingredients: [
      'Chicken Breast — 250 gr',
      'Teriyaki Sauce — 3 tablespoons',
      'Soy Sauce — 1 tablespoon',
      'Garlic — 2 cloves',
      'Sugar — 1 teaspoon',
      'Cooking Oil — 1 tablespoon',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
  ),

  RecipeData(
    id: '3',
    name: 'Spaghetti Bolognese',
    category: 'Pasta',
    instructions:
        '1. Rebus spaghetti hingga matang, lalu tiriskan.\n'
        '2. Tumis bawang putih dan bawang bombai.\n'
        '3. Masukkan daging cincang dan masak hingga berubah warna.\n'
        '4. Tambahkan saus tomat, garam, dan lada.\n'
        '5. Masak saus hingga mengental, lalu sajikan bersama spaghetti.',
    ingredients: [
      'Spaghetti — 200 gr',
      'Ground Beef — 150 gr',
      'Tomato Sauce — 200 ml',
      'Onion — 1 buah',
      'Garlic — 2 cloves',
      'Olive Oil — 1 tablespoon',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg',
  ),

  RecipeData(
    id: '4',
    name: 'Pancakes',
    category: 'Dessert',
    instructions:
        '1. Campurkan tepung, gula, dan baking powder.\n'
        '2. Tambahkan telur, susu, dan mentega cair.\n'
        '3. Aduk hingga adonan tercampur rata.\n'
        '4. Tuang adonan ke wajan anti lengket.\n'
        '5. Balik pancake saat muncul gelembung, lalu masak hingga matang.',
    ingredients: [
      'Flour — 100 gr',
      'Milk — 150 ml',
      'Egg — 1 butir',
      'Sugar — 2 tablespoons',
      'Butter — 2 tablespoons',
      'Baking Powder — 1 teaspoon',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg',
  ),
];
