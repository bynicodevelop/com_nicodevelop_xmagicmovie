import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:com_nicodevelop_xmagicmovie/widgets/resize_button_widget.dart';

void main() {
  testWidgets('ResizeButtonWidget displays the correct icon',
      (WidgetTester tester) async {
    const testIcon = Icons.add;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResizeButtonWidget(
            onPanUpdate: (_) {},
            icon: testIcon,
          ),
        ),
      ),
    );

    expect(find.byIcon(testIcon), findsOneWidget);
  });

  testWidgets('ResizeButtonWidget triggers onPanUpdate callback',
      (WidgetTester tester) async {
    bool callbackTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResizeButtonWidget(
            onPanUpdate: (_) {
              callbackTriggered = true;
            },
            icon: Icons.add,
          ),
        ),
      ),
    );

    await tester.drag(find.byType(GestureDetector), const Offset(10, 10));
    expect(callbackTriggered, isTrue);
  });
}
