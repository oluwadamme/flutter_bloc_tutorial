import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/src/models/models.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => loginHandle == const LoginHandle.foobar() ? mockNotes : null,
    );
  }
}
