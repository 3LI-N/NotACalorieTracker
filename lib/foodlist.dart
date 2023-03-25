class FoodList {
  final int id;
  final String name;
  final String foodCategory;

  FoodList({
    required this.id,
    required this.name,
    required this.foodCategory,
  });

  List<FoodList> foodList() {
    return [
      FoodList(
        id: 2344737,
        name: 'Mango',
        foodCategory: 'Fruit',
      ),
      FoodList(
        id: 2344876,
        name: 'Potato',
        foodCategory: 'vegetable',
      ),
      FoodList(
        id: 2345467,
        name: 'Okra',
        foodCategory: 'vegetable',
      ),
      FoodList(
        id: 2344720,
        name: 'Banana',
        foodCategory: 'Fruit',
      ),
      FoodList(
        id: 2344665,
        name: 'Orange',
        foodCategory: 'Fruit',
      ),
      FoodList(
        id: 2342993,
        name: 'Peanut',
        foodCategory: 'Nuts',
      ),
      FoodList(
        id: 2344769,
        name: 'Blueberries',
        foodCategory: 'Fruit',
      ),
      FoodList(
        id: 2344711,
        name: 'Apple',
        foodCategory: 'Fruit',
      )
    ];
  }
}