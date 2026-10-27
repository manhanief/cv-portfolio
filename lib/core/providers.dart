import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/auth_repository.dart';
import '../data/repositories/cv_repository.dart';
import '../data/seed_data.dart';

enum Backend { firebase, demo }

/// Overridden in `main()` after trying to initialise Firebase.
final backendProvider = Provider<Backend>((_) => Backend.demo);

/// Overridden in `main()` with the loaded instance.
final sharedPrefsProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final cvRepositoryProvider = Provider<CvRepository>((ref) {
  return switch (ref.watch(backendProvider)) {
    Backend.firebase =>
      FirestoreCvRepository(FirebaseFirestore.instance, seed: seedCv),
    Backend.demo => InMemoryCvRepository(seedCv),
  };
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return switch (ref.watch(backendProvider)) {
    Backend.firebase =>
      FirebaseAuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
    Backend.demo => DemoAuthRepository(),
  };
});

final adminProvider = StreamProvider<AdminUser?>(
    (ref) => ref.watch(authRepositoryProvider).watchAdmin());

final isAdminProvider =
    Provider<bool>((ref) => ref.watch(adminProvider).valueOrNull != null);

/// Lets the admin see the page exactly as visitors do without signing out.
final previewModeProvider = StateProvider<bool>((_) => false);

/// The single switch every inline widget reads.
final isEditingProvider = Provider<bool>(
    (ref) => ref.watch(isAdminProvider) && !ref.watch(previewModeProvider));
