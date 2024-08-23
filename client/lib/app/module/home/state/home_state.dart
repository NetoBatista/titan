abstract class HomeState {}

class HomeDefaultState extends HomeState {}

class HomeLoadingate extends HomeState {}

class HomeErrorState extends HomeState {
  String error;
  HomeErrorState(this.error);
}
