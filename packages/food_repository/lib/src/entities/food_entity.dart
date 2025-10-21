import 'package:food_repository/src/entities/macros_entity.dart';

import '../models/models.dart';

class FoodEntity {
  String foodId;
  String picture;
  bool isVeg;
  int spicy;
  String name;
  String description;
  num price;
  num discount;
  Macros macros;

  FoodEntity({
    required this.foodId,
    required this.picture,
    required this.isVeg,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  Map<String, Object?> toDocument() {
    return {
      'foodId': foodId,
      'picture': picture,
      'isVeg': isVeg,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toEntity().toDocument(),
    };
  }

  static FoodEntity fromDocument(Map<String, dynamic> doc) {
    return FoodEntity(
      foodId: doc['foodId'],
      picture: doc['picture'],
      isVeg: doc['isVeg'],
      spicy: doc['spicy'],
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      discount: doc['discount'],
      macros: Macros.fromEntity(MacrosEntity.fromDocument(doc['macros'])),
    );
  }
}