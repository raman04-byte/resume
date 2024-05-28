import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class DimensionEvent extends Equatable {
  const DimensionEvent();
}

class UpdateDimensions extends DimensionEvent {
  final double screenHeight;
  final double screenWidth;

  const UpdateDimensions(this.screenHeight, this.screenWidth);

  @override
  List<Object> get props => [screenHeight, screenWidth];
}

// State
class DimensionState extends Equatable {
  final double screenHeight;
  final double screenWidth;

  const DimensionState({required this.screenHeight, required this.screenWidth});

  @override
  List<Object> get props => [screenHeight, screenWidth];
}

// Bloc
class DimensionBloc extends Bloc<DimensionEvent, DimensionState> {
  DimensionBloc() : super(const DimensionState(screenHeight: 0, screenWidth: 0)) {
    on<UpdateDimensions>(_onUpdateDimensions);
  }

  void _onUpdateDimensions(UpdateDimensions event, Emitter<DimensionState> emit) {
    emit(DimensionState(screenHeight: event.screenHeight, screenWidth: event.screenWidth));
  }

  double scaleH(double value) {
    if (state.screenHeight == 0) return value;
    if (isMobile) {
      return value * (state.screenHeight / 740);
    } else {
      double scalingFactor = getScalingFactor(state.screenWidth);
      return value * (state.screenHeight / scalingFactor);
    }
  }

  double scaleW(double value) {
    if (state.screenWidth == 0) return value;
    if (isMobile) {
      return value * (state.screenWidth / 360);
    } else {
      double scalingFactor = getScalingFactor(state.screenWidth);
      return value * (state.screenWidth / scalingFactor);
    }
  }

  bool get isMobile => state.screenWidth < 600;

  double getScalingFactor(double screenWidth) {
    if (screenWidth >= 1024) {
      return 1024;
    } else if (screenWidth >= 768) {
      return 768;
    } else if (screenWidth >= 640) {
      return 640;
    } else if (screenWidth >= 600) {
      return 600;
    } else {
      return isMobile ? 360 : 740;
    }
  }
}
