import'models/food.dart';

abstract class FoodRepo {
  Future<List<Food>> getFoods() ;
}