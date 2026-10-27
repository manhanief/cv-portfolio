import 'package:cv_portfolio/core/providers.dart';
import 'package:cv_portfolio/features/editing/inline_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  Future<List<String>> pumpField(WidgetTester tester, {required bool editing}) async {
    final saved = <String>[];
    await pumpApp(
      tester,
      Scaffold(
        body: InlineText(value: 'Hello', placeholder: 'Name', onSave: saved.add),
      ),
      overrides: [isEditingProvider.overrideWithValue(editing)],
    );
    return saved;
  }

  testWidgets('visitors see plain text that cannot be edited', (tester) async {
    await pumpField(tester, editing: false);
    await tester.tap(find.text('Hello'));
    await tester.pump();
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('tap edits in place, Enter saves', (tester) async {
    final saved = await pumpField(tester, editing: true);
    await tester.tap(find.text('Hello'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'World');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(saved, ['World']);
    expect(find.byType(TextField), findsNothing);
    // The field shows whatever the parent passes back; here it is unchanged.
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('Esc cancels without saving', (tester) async {
    final saved = await pumpField(tester, editing: true);
    await tester.tap(find.text('Hello'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Discard me');
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pump();
    expect(saved, isEmpty);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('unchanged value is not saved', (tester) async {
    final saved = await pumpField(tester, editing: true);
    await tester.tap(find.text('Hello'));
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(saved, isEmpty);
  });
}
