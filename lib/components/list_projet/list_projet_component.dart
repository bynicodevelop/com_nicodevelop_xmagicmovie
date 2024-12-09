import 'package:com_nicodevelop_xmagicmovie/components/button_delete_project/bloc/project_delete_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/button_project/button_project_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/list_projet/bloc/projects_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/constants.dart';
import 'package:com_nicodevelop_xmagicmovie/models/config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProjectComponent extends StatelessWidget {
  const ListProjectComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProjectDeletionBloc, ProjectDeletionState>(
          listener: (context, state) {
            final LoadingState loadingState = state.loadingState;

            if (loadingState == LoadingState.loading) {
              context.read<ProjectsBloc>().add(const LoadProjects());
            }
          },
        ),
      ],
      child: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          final LoadingState loadingState = state.loadingState;
          final List<ConfigModel> projects = state.projects;

          if (loadingState == LoadingState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (loadingState == LoadingState.loaded && projects.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding * 10,
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.movie_creation_rounded,
                      size: 50,
                      color: Colors.grey.shade500,
                    ),
                    const Text(
                      'Aucun projet trouvé',
                    )
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
            ),
            itemCount: state.projects.length,
            itemBuilder: (context, index) {
              return ButtonProjectComponent(
                config: projects[index],
              );
            },
          );
        },
      ),
    );
  }
}
