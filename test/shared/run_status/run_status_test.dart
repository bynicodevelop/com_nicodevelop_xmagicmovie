import 'package:com_nicodevelop_xmagicmovie/models/crop_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/size_model.dart';
import 'package:com_nicodevelop_xmagicmovie/models/video_data_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/shared/run_status/run_status.dart';

class MockRunBloc extends MockBloc<RunEvent, RunState> implements RunBloc {}

void main() {
  late MockRunBloc mockRunBloc;

  setUp(() {
    mockRunBloc = MockRunBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<RunBloc>(
          create: (_) => mockRunBloc,
          child: RunStatus(
            builder: (context, isLoading) {
              return Text(isLoading ? 'Loading...' : 'Not Loading');
            },
          ),
        ),
      ),
    );
  }

  testWidgets('displays Loading... when state is RunInProgressState',
      (tester) async {
    whenListen(
      mockRunBloc,
      Stream.fromIterable([
        RunInProgressState(
          videoSize: SizeModel(0, 0),
          file: VideoDataModel(
              projectId: "",
              name: "",
              path: "",
              uniqueFileName: "",
              xfile: XFile(""),
              size: SizeModel(0, 0)),
          crop: CropModel(
            cropX: 0,
            cropY: 0,
            cropWidth: 0,
            cropHeight: 0,
          ),
        )
      ]),
      initialState: RunInitialState(),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('displays Not Loading when state is RunInitialState',
      (tester) async {
    whenListen(
      mockRunBloc,
      Stream.fromIterable([RunInitialState()]),
      initialState: RunInitialState(),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Not Loading'), findsOneWidget);
  });

  testWidgets('displays Loading... when state is RunProgressUpdate',
      (tester) async {
    whenListen(
      mockRunBloc,
      Stream.fromIterable([const RunProgressUpdate(progress: 50)]),
      initialState: RunInitialState(),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Loading...'), findsOneWidget);
  });
}
