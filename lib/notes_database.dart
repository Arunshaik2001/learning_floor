import 'dart:async';

import 'package:floor/floor.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/entities/note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'notes_database.g.dart';

@Database(version: 1, entities: [Note])
abstract class NotesDatabase extends FloorDatabase {
  NotesDao get noteDao;
}
