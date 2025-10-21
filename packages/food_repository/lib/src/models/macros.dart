import '../entities/macros_entity.dart';

class Macros {
  num calories;
  num proteins;
  num fat;
  num carbs;

  Macros({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
  });

  MacrosEntity toEntity() {
    return MacrosEntity(
      calories: calories,
      proteins: proteins,
      fat: fat,
      carbs: carbs,
    );
  }

  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
        calories: entity.calories,
        proteins: entity.proteins,
        fat: entity.fat,
        carbs: entity.carbs
    );
  }
}