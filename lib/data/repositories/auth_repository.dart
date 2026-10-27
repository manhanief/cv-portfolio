import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminUser {
  const AdminUser({required this.uid, required this.email});
  final String uid;
  final String email;
}

enum AuthFailure { invalidCredentials, notAuthorized }

class AuthException implements Exception {
  const AuthException(this.failure);
  final AuthFailure failure;
}

abstract interface class AuthRepository {
  /// Emits the signed-in admin, or null for visitors.
  Stream<AdminUser?> watchAdmin();
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}

/// Admin status comes from `/admins/{uid}`, the same check the security
/// rules use, so the UI and the server always agree.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._db);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  Future<bool> _isAdmin(String uid) async =>
      (await _db.doc('admins/$uid').get()).exists;

  @override
  Stream<AdminUser?> watchAdmin() => _auth.authStateChanges().asyncMap((u) async {
        if (u == null) return null;
        try {
          return await _isAdmin(u.uid)
              ? AdminUser(uid: u.uid, email: u.email ?? '')
              : null;
        } on FirebaseException {
          return null;
        }
      });

  @override
  Future<void> signIn(String email, String password) async {
    final UserCredential cred;
    try {
      cred = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
    } on FirebaseAuthException {
      // Don't reveal whether the email exists.
      throw const AuthException(AuthFailure.invalidCredentials);
    }
    if (!await _isAdmin(cred.user!.uid)) {
      await _auth.signOut();
      throw const AuthException(AuthFailure.notAuthorized);
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();
}

class DemoAuthRepository implements AuthRepository {
  static const demoEmail = 'admin@demo.dev';
  static const demoPassword = 'admin';

  AdminUser? _user;
  final _controller = StreamController<AdminUser?>.broadcast();

  @override
  Stream<AdminUser?> watchAdmin() async* {
    yield _user;
    yield* _controller.stream;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (email.trim() != demoEmail || password != demoPassword) {
      throw const AuthException(AuthFailure.invalidCredentials);
    }
    _controller.add(_user = const AdminUser(uid: 'demo', email: demoEmail));
  }

  @override
  Future<void> signOut() async => _controller.add(_user = null);
}
