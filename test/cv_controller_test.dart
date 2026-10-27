import 'dart:typed_data';

import 'package:cv_portfolio/core/providers.dart';
import 'package:cv_portfolio/data/models/cv_data.dart';
import 'package:cv_portfolio/data/repositories/cv_repository.dart';
import 'package:cv_portfolio/data/seed_data.dart';
import 'package:cv_portfolio/features/cv/cv_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FailingRepo implements CvRepository {
  @override
  Stream<CvData> watch() => Stream.value(seedCv);
  @override
  Future<void> updateField(CvField field, Object? value) async =>
      throw Exception('permission-denied');
  @override
  Future<void> ensureExists(CvData seed) async {}
  @override
  Future<String> uploadPhoto(Uint8List bytes, String contentType) =>
      throw UnimplementedError();
}

void main() {
  Future<ProviderContainer> containerWith(CvRepository repo) async {
    final c = ProviderContainer(
        overrides: [cvRepositoryProvider.overrideWithValue(repo)]);
    addTearDown(c.dispose);
    c.listen(cvControllerProvider, (_, _) {});
    await c.read(cvControllerProvider.future);
    return c;
  }

  test('applies the edit immediately and persists it', () async {
    final repo = InMemoryCvRepository(seedCv);
    final c = await containerWith(repo);
    final future = c.read(cvControllerProvider.notifier).edit(CvField.profile,
        (cv) => cv.copyWith(profile: cv.profile.copyWith(name: 'Esman')));

    // Optimistic: visible before the write completes.
    expect(c.read(cvControllerProvider).value!.profile.name, 'Esman');
    expect(c.read(saveStatusProvider).state, SaveState.saving);

    await future;
    expect(c.read(saveStatusProvider).state, SaveState.saved);
    expect((await repo.watch().first).profile.name, 'Esman');
  });

  test('rolls back when the write fails', () async {
    final c = await containerWith(_FailingRepo());
    await c.read(cvControllerProvider.notifier).edit(CvField.skills,
        (cv) => cv.copyWith(skills: const []));

    expect(c.read(cvControllerProvider).value!.skills, seedCv.skills);
    final status = c.read(saveStatusProvider);
    expect(status.state, SaveState.error);
    expect(status.error, contains('permission-denied'));
  });

  test('round-trips through JSON (Firestore format)', () {
    expect(CvData.fromJson(seedCv.toJson()), seedCv);
  });
}
