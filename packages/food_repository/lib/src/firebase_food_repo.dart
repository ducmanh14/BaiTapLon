import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_repository/food_repository.dart';

class FirebaseFoodRepo implements FoodRepo {
  final foodCollection = FirebaseFirestore.instance.collection('foods');

  Future<List<Food>> getFoods() async {
    try {
      return await foodCollection
          .get()
          .then((value) => value.docs.map((e) =>
          Food.fromEntity(FoodEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}