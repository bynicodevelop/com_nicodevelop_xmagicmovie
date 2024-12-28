import 'package:com_nicodevelop_xmagicmovie/components/zoom/bloc/zoom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZoomComponent extends StatelessWidget {
  const ZoomComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZoomBloc, ZoomState>(builder: (context, state) {
      double value = 0;

      if (state is ZoomInitialState) {
        value = state.value;
      }

      return Slider(
        value: value,
        min: -100,
        max: 100,
        divisions: 200,
        label: value.toStringAsFixed(0),
        onChanged: (double newValue) => context.read<ZoomBloc>().add(
              ZoomChangedEvent(
                value: newValue,
              ),
            ),
      );
    });
  }
}
