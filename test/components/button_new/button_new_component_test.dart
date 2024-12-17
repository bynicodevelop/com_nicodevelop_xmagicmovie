import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_new/button_new_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/tools/bloc/tool_bloc.dart';
import 'package:com_nicodevelop_xmagicmovie/components/video/bloc/video_bloc.dart';

class MockToolBloc extends MockBloc<ToolEvent, ToolState> implements ToolBloc {}

class MockVideoBloc extends MockBloc<VideoEvent, VideoState>
    implements VideoBloc {}

class MockRunBloc extends MockBloc<RunEvent, RunState> implements RunBloc {}

void main() {
  late MockToolBloc mockToolBloc;
  late MockVideoBloc mockVideoBloc;
  late MockRunBloc mockRunBloc;

  setUp(() {
    mockToolBloc = MockToolBloc();
    mockVideoBloc = MockVideoBloc();
    mockRunBloc = MockRunBloc();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToolBloc>.value(value: mockToolBloc),
        BlocProvider<VideoBloc>.value(value: mockVideoBloc),
        BlocProvider<RunBloc>.value(value: mockRunBloc),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: ButtonNewComponent(),
        ),
      ),
    );
  }

  testWidgets('ButtonNewComponent renders correctly',
      (WidgetTester tester) async {
    when(() => mockToolBloc.state).thenReturn(const ToolReset(false, false));
    when(() => mockRunBloc.state).thenReturn(RunInitialState());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.movie_filter_outlined), findsOneWidget);
  });
}
