import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/buttons/button_crop_component.dart';

void main() {
  testWidgets('ButtonCropComponent renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ButtonCropComponent(),
        ),
      ),
    );

    expect(find.byIcon(Icons.crop), findsOneWidget);
  });

  testWidgets('ButtonCropComponent is disabled when readOnly is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ButtonCropComponent(readOnly: true),
        ),
      ),
    );

    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    expect(iconButton.onPressed, isNull);
  });

  testWidgets('ButtonCropComponent is enabled when readOnly is false',
      (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonCropComponent(
            readOnly: false,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    expect(iconButton.onPressed, isNotNull);

    await tester.tap(find.byType(IconButton));
    expect(pressed, isTrue);
  });

  testWidgets('ButtonCropComponent icon color changes based on active state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ButtonCropComponent(active: true),
        ),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.crop));
    expect(icon.color,
        Theme.of(tester.element(find.byType(IconButton))).colorScheme.primary);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ButtonCropComponent(active: false),
        ),
      ),
    );

    final iconInactive = tester.widget<Icon>(find.byIcon(Icons.crop));
    expect(
        iconInactive.color,
        Theme.of(tester.element(find.byType(IconButton)))
            .colorScheme
            .onSurface);
  });
}
