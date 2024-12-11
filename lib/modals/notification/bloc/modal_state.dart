part of 'modal_bloc.dart';

enum ModalType {
  success,
  warning,
  error,
}

sealed class ModalState extends Equatable {
  final bool isModalOpen;
  final String title;
  final String message;
  final ModalType type;

  const ModalState({
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

final class ModalInitial extends ModalState {
  const ModalInitial({
    super.isModalOpen,
    super.title,
    super.message,
    super.type,
  });
}
