import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modal_event.dart';
part 'modal_state.dart';

class ModalBloc extends Bloc<ModalEvent, ModalState> {
  final int closeDuration;
  Timer? _closeTimer;

  ModalBloc({
    this.closeDuration = 5,
  }) : super(const ModalInitial()) {
    on<OnOpenModal>((event, emit) {
      _closeTimer?.cancel();

      emit(ModalInitial(
        isModalOpen: true,
        title: event.title,
        message: event.message,
        type: event.type,
      ));

      _closeTimer = Timer(
          Duration(
            seconds: closeDuration,
          ), () {
        add(const OnCloseModal());
      });
    });

    on<OnCloseModal>((event, emit) {
      _closeTimer?.cancel();

      emit(ModalInitial(
        isModalOpen: false,
        title: event.title,
        message: event.message,
      ));
    });
  }
}
