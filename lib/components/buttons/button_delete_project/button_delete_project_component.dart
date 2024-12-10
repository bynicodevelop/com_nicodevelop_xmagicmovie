import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_delete_project/bloc/project_delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonDeleteProjectComponent extends StatelessWidget {
  final Function callback;

  const ButtonDeleteProjectComponent({
    required this.callback,
    super.key,
  });

  void _confirmModal(
    context,
  ) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Supprimer le projet'),
            content:
                const Text('Êtes-vous sûr de vouloir supprimer ce projet ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  callback();
                },
                child: const Text('Supprimer'),
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDeletionBloc, ProjectDeletionState>(
        builder: (context, state) {
      return IconButton(
        onPressed: () => _confirmModal(
          context,
        ),
        icon: Icon(
          Icons.delete_rounded,
          color: Colors.red.shade400,
        ),
      );
    });
  }
}
