import 'package:cv_portfolio/core/providers.dart';
import 'package:cv_portfolio/data/repositories/auth_repository.dart';
import 'package:cv_portfolio/features/cv/cv_page.dart';
import 'package:cv_portfolio/features/cv/sections/content_sections.dart';
import 'package:cv_portfolio/features/cv/sections/header_section.dart';
import 'package:cv_portfolio/features/editing/editable_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('desktop puts the header in a sidebar beside the content',
      (tester) async {
    await pumpApp(tester, const CvPage(), size: const Size(1400, 1000));
    final header = tester.getTopLeft(find.byType(HeaderSection));
    final about = tester.getTopLeft(find.byType(AboutSection));
    expect(about.dx, greaterThan(header.dx));
    expect((about.dy - header.dy).abs(), lessThan(1));
  });

  testWidgets('mobile stacks sections in one column without overflow',
      (tester) async {
    await pumpApp(tester, const CvPage(), size: const Size(375, 800));
    final header = tester.getTopLeft(find.byType(HeaderSection));
    final about = tester.getTopLeft(find.byType(AboutSection));
    expect(about.dy, greaterThan(header.dy));
    expect(tester.takeException(), isNull);
  });

  testWidgets('admin login turns on inline editing on the same page',
      (tester) async {
    final container = await pumpApp(tester, const CvPage());
    expect(find.byType(EditableFrame), findsNothing);

    await tester.ensureVisible(find.byIcon(Icons.lock_outline));
    await tester.tap(find.byIcon(Icons.lock_outline));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).at(0), DemoAuthRepository.demoEmail);
    await tester.enterText(
        find.byType(TextFormField).at(1), DemoAuthRepository.demoPassword);
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(container.read(isEditingProvider), isTrue);
    expect(find.byType(EditableFrame), findsWidgets);
    expect(find.byType(CvPage), findsOneWidget);
  });

  testWidgets('wrong password shows an error and stays a visitor',
      (tester) async {
    final container = await pumpApp(tester, const CvPage());
    await tester.ensureVisible(find.byIcon(Icons.lock_outline));
    await tester.tap(find.byIcon(Icons.lock_outline));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'x@y.z');
    await tester.enterText(find.byType(TextFormField).at(1), 'nope');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid email or password'), findsOneWidget);
    expect(container.read(isEditingProvider), isFalse);
  });

  testWidgets('edit mode fits on a small phone', (tester) async {
    final container = await pumpApp(tester, const CvPage(),
        size: const Size(360, 780));
    // Not awaited: the demo delay only elapses while the tester pumps.
    container
        .read(authRepositoryProvider)
        .signIn(DemoAuthRepository.demoEmail, DemoAuthRepository.demoPassword);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(container.read(isEditingProvider), isTrue);
    expect(tester.takeException(), isNull);
  });
}
