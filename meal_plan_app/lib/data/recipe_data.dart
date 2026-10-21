
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
        'Kupas dan serut pepaya muda. Haluskan cabai dan bawang putih. '
        'Campurkan air jeruk nipis, gula, dan kecap ikan. '
        'Masukkan pepaya dan tomat, lalu aduk rata. Sajikan selagi segar.',
    ingredients: [
      '1/2 buah Pepaya muda',
      '2 buah Tomat',
      '1 sdm Air jeruk nipis',
      '2 siung Bawang putih',
      '2 buah Cabai',
      '1 sdt Gula',
      '1 sdm Kecap ikan',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/rlwcc51598734603.jpg',
  ),

  RecipeData(
    id: '2',
    name: 'Chicken Teriyaki',
    category: 'Chicken',
    instructions:
        'Potong ayam menjadi bagian kecil. Campurkan kecap asin, '
        'saus teriyaki, dan gula. Panaskan sedikit minyak di wajan. '
        'Masak ayam hingga matang, lalu masukkan saus. '
        'Aduk hingga saus mengental dan sajikan.',
    ingredients: [
      '250 g Dada ayam',
      '3 sdm Saus teriyaki',
      '1 sdm Kecap asin',
      '2 siung Bawang putih',
      '1 sdt Gula',
      '1 sdm Minyak goreng',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
  ),

  RecipeData(
    id: '3',
    name: 'Spaghetti Bolognese',
    category: 'Pasta',

    instructions:
        'Rebus spaghetti hingga matang, lalu tiriskan. '
        'Tumis bawang putih dan bawang bombai. '
        'Masukkan daging cincang dan masak hingga berubah warna. '
        'Tambahkan saus tomat, garam, dan lada. '
        'Masak saus hingga mengental, lalu sajikan bersama spaghetti.',
    ingredients: [
      '200 g Spaghetti',
      '150 g Daging sapi cincang',
      '200 ml Saus tomat',
      '1 buah Bawang bombai',
      '2 siung Bawang putih',
      '1 sdm Minyak zaitun',
      'Secukupnya Garam',
      'Secukupnya Lada',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg',
  ),

  RecipeData(
    id: '4',
    name: 'Pancakes',
    category: 'Dessert',
    instructions:
        'Campurkan tepung, gula, dan baking powder. '
        'Tambahkan telur, susu, dan mentega cair. '
        'Aduk hingga adonan tercampur rata. '
        'Tuang adonan ke wajan anti lengket. '
        'Balik pancake saat muncul gelembung, lalu masak hingga matang.',
    ingredients: [
      '100 g Tepung terigu',
      '150 ml Susu cair',
      '1 butir Telur',
      '2 sdm Gula',
      '2 sdm Mentega',
      '1 sdt Baking powder',
    ],
    image:
        'https://www.themealdb.com/images/media/meals/rwuyqx1511383174.jpg',
  ),
];