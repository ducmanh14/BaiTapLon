part of 'get_food_bloc.dart';

sealed class GetFoodEvent extends Equatable {
  const GetFoodEvent();

  @override
  List<Object> get props => [];
}

class GetFood extends GetFoodEvent{}