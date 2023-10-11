import 'package:bloc/bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(
    estimatedSwitch: false,
    isHidden: true,
    featureOn: false,
    isVisible: false,
  ));
  void esSwitch() => emit(
    HomeState(
      estimatedSwitch: !state.estimatedSwitch,
      isVisible: state.isVisible,
      isHidden: state.isHidden,
      featureOn: state.featureOn,
      dragSize:state.dragSize,
    )
  );
  void visibleSwitch(bool value) => emit(
    HomeState(
      isVisible: value,
      estimatedSwitch: state.estimatedSwitch,
      isHidden: state.isHidden,
      featureOn: state.featureOn,
      dragSize: state.dragSize,
    )
  );
  void featureSwitch() => emit(
      HomeState(
        featureOn: !state.featureOn,
        isVisible: state.isVisible,
        estimatedSwitch: state.estimatedSwitch,
        isHidden: state.isHidden,
        dragSize: state.dragSize,
      )
  );
  void hiddenSwitch() => emit(
      HomeState(
        isHidden: !state.isHidden,
        isVisible: state.isVisible,
        estimatedSwitch: state.estimatedSwitch,
        featureOn: state.featureOn,
        dragSize: state.dragSize,
      )
  );
  void changeDragSize(size) => emit(
      HomeState(
        isHidden: state.isHidden,
        isVisible: state.isVisible,
        estimatedSwitch: state.estimatedSwitch,
        featureOn: state.featureOn,
        dragSize: size,
      )
  );
}
