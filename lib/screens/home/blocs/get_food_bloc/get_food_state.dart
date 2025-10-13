part of 'get_food_bloc.dart';

sealed class GetFoodState extends Equatable {
  const GetFoodState();

  @override
  List<Object> get props => [];
}

final class GetFoodInitial extends GetFoodState {}

final class GetFoodFailure extends GetFoodState {}
final class GetFoodLoading extends GetFoodState {}
final class GetFoodSuccess extends GetFoodState {
  final List<Food> foods;

  const GetFoodSuccess(this.foods);

  @override
  List<Object> get props => [foods];
}