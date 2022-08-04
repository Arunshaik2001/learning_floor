import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/entities/note.dart';
import 'package:learning_floor/notes_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'views/notes_widget.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final database =
      await $FloorNotesDatabase.databaseBuilder('notes_database1.db').build();
  final NotesDao dao = database.noteDao;
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 1),
  ));
  await remoteConfig.fetchAndActivate();
  runApp(ChangeNotifierProvider(child: NotesApp(dao),create: (_) => remoteConfig));
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










