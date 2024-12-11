import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/modals/notification/bloc/modal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationModal extends StatelessWidget {
  const NotificationModal({super.key});

  IconData _typeIcon(ModalType type) {
    switch (type) {
      case ModalType.success:
        return Icons.check_circle;
      case ModalType.warning:
        return Icons.warning;
      case ModalType.error:
        return Icons.error;
      default:
        return Icons.check_circle;
    }
  }

  Color _typeColor(ModalType type) {
    switch (type) {
      case ModalType.success:
        return Colors.green.shade600;
      case ModalType.warning:
        return Colors.amber.shade600;
      case ModalType.error:
        return ThemeData().colorScheme.error;
      default:
        return Colors.green.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModalBloc, ModalState>(
      builder: (context, state) {
        if (!state.isModalOpen) {
          return const SizedBox.shrink();
        }

        final ModalType type = state.type;

        return Container(
          padding: const EdgeInsets.all(kDefaultPadding * 2),
          decoration: BoxDecoration(
            color: ThemeData().colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: kDefaultPadding,
                        ),
                        child: Icon(
                          _typeIcon(type),
                          size: kDefaultPadding * 2.5,
                          color: _typeColor(type),
                        ),
                      ),
                      Text(
                        state.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ModalBloc>().add(
                            const OnCloseModal(),
                          );
                    },
                    icon: const Icon(
                      Icons.close,
                      size: kDefaultPadding * 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(
                state.message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
