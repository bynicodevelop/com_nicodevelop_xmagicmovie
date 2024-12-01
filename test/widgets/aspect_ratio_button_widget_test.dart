import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:com_nicodevelop_xmagicmovie/components/crop_selector/bloc/crop_selector_state.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/aspect_ratio_button_widget.dart';

void main() {
  testWidgets('AspectRationButtonWidget displays correct icon and color when aspect ratio is not locked', (WidgetTester tester) async {
    final CropSelectorState state = CropSelectorState(lockedAspectRatio: 1.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AspectRationButtonWidget(
            onPressed: () {},
            icon: Icons.aspect_ratio,
            aspectRatio: 1.5,
            state: state,
          ),
        ),
      ),
    );

    final iconFinder = find.byIcon(Icons.aspect_ratio);
    expect(iconFinder, findsOneWidget);

    final iconWidget = tester.widget<Icon>(iconFinder);
    expect(iconWidget.color, Colors.white);
  });

  testWidgets('AspectRationButtonWidget displays correct icon and color when aspect ratio is locked', (WidgetTester tester) async {
    final CropSelectorState state = CropSelectorState(lockedAspectRatio: 1.5);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AspectRationButtonWidget(
            onPressed: () {},
            icon: Icons.aspect_ratio,
            aspectRatio: 1.5,
            state: state,
          ),
        ),
      ),
    );

    final iconFinder = find.byIcon(Icons.aspect_ratio);
    expect(iconFinder, findsOneWidget);

    final iconWidget = tester.widget<Icon>(iconFinder);
    expect(iconWidget.color, Colors.white.withOpacity(0.5));
  });

  testWidgets('AspectRationButtonWidget triggers onPressed callback when pressed', (WidgetTester tester) async {
    bool pressed = false;
    final CropSelectorState state = CropSelectorState(lockedAspectRatio: 1.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AspectRationButtonWidget(
            onPressed: () {
              pressed = true;
            },
            icon: Icons.aspect_ratio,
            aspectRatio: 1.5,
            state: state,
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(IconButton);
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(pressed, isTrue);
  });
}