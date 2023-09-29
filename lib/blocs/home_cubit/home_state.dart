part of 'home_cubit.dart';

class HomeState {
  bool estimatedSwitch,isVisible,isHidden,featureOn;
  double dragSize;
  HomeState({
    required this.estimatedSwitch,
    required this.isVisible,
    required this.isHidden,
    required this.featureOn,
    this.dragSize = 0,
  });
}
