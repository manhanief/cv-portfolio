import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cv_data.dart';

/// The only gateway the UI uses for CV content. Swap the implementation
/// (e.g. for a REST API) without touching any widget.
abstract interface class CvRepository {
  Stream<CvData> watch();

  /// Writes a single top-level field; [value] is its JSON representation.
  Future<void> updateField(CvField field, Object? value);

  /// Creates the document from [seed] if it does not exist yet, so the first
  /// single-field edit doesn't wipe the sample content.
  Future<void> ensureExists(CvData seed);

  /// Stores a profile photo and returns the URL to put in `photoUrl`.
  Future<String> uploadPhoto(Uint8List bytes, String contentType);
}

/// Photos are kept inline as data URIs so the project stays on the free
/// Spark plan (new projects need Blaze for Cloud Storage). The picker already
/// downsizes to ~400px, which is far below Firestore's 1 MiB document limit.
const maxPhotoBytes = 300 * 1024;

String photoDataUri(Uint8List bytes, String contentType) {
  if (bytes.length > maxPhotoBytes) {
    throw ArgumentError('Photo is too large (max ${maxPhotoBytes ~/ 1024} KB).');
  }
  return Uri.dataFromBytes(bytes, mimeType: contentType).toString();
}

class FirestoreCvRepository implements CvRepository {
  FirestoreCvRepository(this._db, {required this.seed});

  final FirebaseFirestore _db;
  final CvData seed;

  DocumentReference<Map<String, dynamic>> get _doc => _db.doc('cv/main');

  @override
  Stream<CvData> watch() => _doc.snapshots().map((snap) {
        final data = snap.data();
        return data == null ? seed : CvData.fromJson(data);
      });

  @override
  Future<void> updateField(CvField field, Object? value) => _doc.set(
        {field.name: value, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );

  @override
  Future<void> ensureExists(CvData seed) async {
    final snap = await _doc.get();
    if (!snap.exists) {
      await _doc.set({...seed.toJson(), 'updatedAt': FieldValue.serverTimestamp()});
    }
  }

  @override
  Future<String> uploadPhoto(Uint8List bytes, String contentType) async =>
      photoDataUri(bytes, contentType);
}

/// Used when Firebase isn't configured: local demo, nothing is persisted.
class InMemoryCvRepository implements CvRepository {
  InMemoryCvRepository(CvData initial) : _json = initial.toJson();

  Map<String, dynamic> _json;
  final _controller = StreamController<CvData>.broadcast();

  CvData get _current => CvData.fromJson(jsonDecode(jsonEncode(_json)));

  @override
  Stream<CvData> watch() async* {
    yield _current;
    yield* _controller.stream;
  }

  @override
  Future<void> updateField(CvField field, Object? value) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    _json = {..._json, field.name: value};
    _controller.add(_current);
  }

  @override
  Future<void> ensureExists(CvData seed) async {}

  @override
  Future<String> uploadPhoto(Uint8List bytes, String contentType) async =>
      photoDataUri(bytes, contentType);
}
