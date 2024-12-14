import 'package:bloc_test/bloc_test.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_open_file/button_open_file_component.dart';
import 'package:com_nicodevelop_xmagicmovie/components/buttons/button_run/bloc/run_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRunBloc extends MockBloc<RunEvent, RunState> implements RunBloc {}

void main() {
  late MockRunBloc mockRunBloc;

  setUp(() {
    mockRunBloc = MockRunBloc();
  });

  Widget createWidgetUnderTest(void Function(String) onPressed) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<RunBloc>.value(
          value: mockRunBloc,
          child: ButtonOpenFileComponent(onPressed: onPressed),
        ),
      ),
    );
  }

  testWidgets(
      'Affiche le bouton lorsqu\'il y a un chemin valide dans RunSuccessState',
      (WidgetTester tester) async {
    const String fakePath = '/path/to/final/file.mp4';
    const String parentPath = '/path/to/final';

    when(() => mockRunBloc.state)
        .thenReturn(const RunSuccessState(finalPath: fakePath));

    bool wasPressed = false;
    void handlePress(String link) {
      wasPressed = true;
      expect(link, parentPath);
    }

    await tester.pumpWidget(createWidgetUnderTest(handlePress));

    // Vérifie que le bouton est affiché
    expect(find.byIcon(Icons.open_in_new_rounded), findsOneWidget);

    // Appuie sur le bouton
    await tester.tap(find.byIcon(Icons.open_in_new_rounded));
    await tester.pump();

    // Vérifie que le callback a été appelé avec le bon chemin
    expect(wasPressed, isTrue);
  });

  testWidgets(
      'N\'affiche pas le bouton lorsque l\'état n\'est pas RunSuccessState',
      (WidgetTester tester) async {
    when(() => mockRunBloc.state).thenReturn(RunInitialState());

    await tester.pumpWidget(createWidgetUnderTest((_) {}));

    // Vérifie que le bouton n'est pas affiché
    expect(find.byIcon(Icons.open_in_new_rounded), findsNothing);
  });
}
