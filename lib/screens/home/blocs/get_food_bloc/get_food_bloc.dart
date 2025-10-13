import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_repository/food_repository.dart';

part 'get_food_event.dart';
part 'get_food_state.dart';

class GetFoodBloc extends Bloc<GetFoodEvent, GetFoodState> {
  final FoodRepo _foodRepo;

  GetFoodBloc(this._foodRepo) : super(GetFoodInitial()) {
    on<GetFood>((event, emit) async {
      emit(GetFoodLoading());
      try {
        List<Food> foods = await _foodRepo.getFoods();
        emit(GetFoodSuccess(foods));
      } catch (e) {
        emit(GetFoodFailure());
      }
    });
  }
}