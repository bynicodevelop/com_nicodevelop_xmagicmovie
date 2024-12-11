part of 'modal_bloc.dart';

sealed class ModalEvent extends Equatable {
  final bool isModalOpen;
  final String title;
  final String message;
  final ModalType type;

  const ModalEvent({
    this.isModalOpen = false,
    this.title = '',
    this.message = '',
    this.type = ModalType.success,
  });

  @override
  List<Object> get props => [
        isModalOpen,
        title,
        message,
        type,
      ];
}

class OnOpenModal extends ModalEvent {
  const OnOpenModal({
    super.isModalOpen = true,
    super.title,
    super.message,
    super.type,
  });
}

class OnCloseModal extends ModalEvent {
  const OnCloseModal({
    super.isModalOpen,
    super.title,
    super.message,
    super.type,
  });
}
