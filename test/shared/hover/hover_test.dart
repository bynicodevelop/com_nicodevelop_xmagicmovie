import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:com_nicodevelop_xmagicmovie/components/shared/hover/hover.dart';

void main() {
  testWidgets('Hover widget changes state on mouse enter and exit',
      (WidgetTester tester) async {
    bool isHover = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Hover(
            builder: (context, hover) {
              isHover = hover;
              return Container(
                key: const Key('hover-container'),
                color: hover ? Colors.blue : Colors.red,
                width: 100,
                height: 100,
              );
            },
          ),
        ),
      ),
    );

    // Initial state should be false
    expect(isHover, false);

    // Simulate mouse enter
    final container = find.byKey(const Key('hover-container'));
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer();
    await tester.pump();
    await gesture.moveTo(tester.getCenter(container));
    await tester.pump();

    // State should be true after mouse enter
    expect(isHover, true);

    // Simulate mouse exit
    await gesture.moveTo(const Offset(-100, -100));
    await tester.pump();

    // State should be false after mouse exit
    expect(isHover, false);
  });
}
