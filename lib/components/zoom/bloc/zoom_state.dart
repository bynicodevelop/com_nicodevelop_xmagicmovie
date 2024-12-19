part of 'zoom_bloc.dart';

sealed class ZoomState extends Equatable {
  const ZoomState();

  @override
  List<Object> get props => [];
}

final class ZoomInitialState extends ZoomState {
  final double value;

  const ZoomInitialState({required this.value});

  @override
  List<Object> get props => [
        value,
      ];
}
