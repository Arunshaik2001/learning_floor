// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorNotesDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NotesDatabaseBuilder databaseBuilder(String name) =>
      _$NotesDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NotesDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NotesDatabaseBuilder(null);
}

class _$NotesDatabaseBuilder {
  _$NotesDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$NotesDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NotesDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NotesDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NotesDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NotesDatabase extends NotesDatabase {
  _$NotesDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NotesDao? _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NotesDao get noteDao {
    return _noteDaoInstance ??= _$NotesDao(database, changeListener);
  }
}

class _$NotesDao extends NotesDao {
  _$NotesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Future<Note?> findNoteById(int id) async {
    return _queryAdapter.query('SELECT * FROM note WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Note(row['id'] as int?,
            row['title'] as String, row['description'] as String),
        arguments: [id]);
  }

  @override
  Stream<List<Note>> findAllNotesAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM note',
        mapper: (Map<String, Object?> row) => Note(row['id'] as int?,
            row['title'] as String, row['description'] as String),
        queryableName: 'Note',
        isView: false);
  }

  @override
  Future<void> deleteAllNotes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _noteDeletionAdapter.delete(note);
  }
}
