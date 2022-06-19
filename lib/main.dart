import 'package:flutter/material.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/notes_database.dart';

import 'views/notes_widget.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorNotesDatabase.databaseBuilder('notes_database1.db').build();
  final NotesDao dao = database.noteDao;

  runApp(NotesApp(dao));
}

class NotesApp extends StatelessWidget {
  final NotesDao dao;

  const NotesApp(this.dao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: NotesWidget(
        title: 'Notes App',
        dao: dao,
      ),
    );
  }
}










