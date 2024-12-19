part of 'zoom_bloc.dart';

sealed class ZoomEvent extends Equatable {
  const ZoomEvent();

  @override
  List<Object> get props => [];
}

final class ZoomChangedEvent extends ZoomEvent {
  final double value;

  const ZoomChangedEvent({required this.value});

  @override
  List<Object> get props => [
        value,
      ];
}
