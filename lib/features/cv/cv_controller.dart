import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/cv_data.dart';

enum SaveState { idle, saving, saved, error }

class SaveStatus {
  const SaveStatus(this.state, [this.error]);
  final SaveState state;
  final String? error;
}

final saveStatusProvider = StateProvider<SaveStatus>(
    (_) => const SaveStatus(SaveState.idle));

final cvControllerProvider =
    StreamNotifierProvider<CvController, CvData>(CvController.new);

/// Holds the CV and applies edits optimistically: the UI updates at once,
/// the write runs in the background, and a failure rolls the change back.
class CvController extends StreamNotifier<CvData> {
  int _pending = 0;

  @override
  Stream<CvData> build() => ref.watch(cvRepositoryProvider).watch();

  Future<void> edit(CvField field, CvData Function(CvData) change) async {
    final previous = state.valueOrNull;
    if (previous == null) return;
    final next = change(previous);
    if (next == previous) return;

    state = AsyncData(next);
    _setStatus(const SaveStatus(SaveState.saving), delta: 1);
    try {
      await ref
          .read(cvRepositoryProvider)
          .updateField(field, next.toJson()[field.name]);
      _setStatus(const SaveStatus(SaveState.saved), delta: -1);
    } catch (e) {
      // Roll back only this field, keeping any other edits made meanwhile.
      final current = state.valueOrNull ?? next;
      final restored = CvData.fromJson({
        ...current.toJson(),
        field.name: previous.toJson()[field.name],
      });
      state = AsyncData(restored);
      _setStatus(SaveStatus(SaveState.error, e.toString()), delta: -1);
    }
  }

  Future<void> uploadPhoto(Uint8List bytes, String contentType) async {
    _setStatus(const SaveStatus(SaveState.saving), delta: 1);
    try {
      final url =
          await ref.read(cvRepositoryProvider).uploadPhoto(bytes, contentType);
      _setStatus(const SaveStatus(SaveState.saved), delta: -1);
      await edit(CvField.profile,
          (cv) => cv.copyWith(profile: cv.profile.copyWith(photoUrl: url)));
    } catch (e) {
      _setStatus(SaveStatus(SaveState.error, e.toString()), delta: -1);
    }
  }

  void _setStatus(SaveStatus status, {required int delta}) {
    _pending += delta;
    // Keep showing "saving" while other writes are still in flight.
    final shown = status.state == SaveState.saved && _pending > 0
        ? const SaveStatus(SaveState.saving)
        : status;
    ref.read(saveStatusProvider.notifier).state = shown;
  }
}
