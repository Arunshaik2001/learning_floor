import 'package:floor/floor.dart';

import '../entities/note.dart';

@dao
abstract class NotesDao {
  @Query('SELECT * FROM note WHERE id = :id')
  Future<Note?> findNoteById(int id);

  @Query('SELECT * FROM note')
  Stream<List<Note>> findAllNotesAsStream();

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @Query("DELETE FROM note")
  Future<void> deleteAllNotes();
}
