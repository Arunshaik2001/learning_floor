

import 'package:flutter/material.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/entities/note.dart';
import 'package:learning_floor/views/note_item_widget.dart';

class NotesListView extends StatelessWidget {
  final NotesDao dao;

  const NotesListView({
    Key? key,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Note>>(
        stream: dao.findAllNotesAsStream(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return Container();
          final notes = snapshot.requireData;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (_, index) {
              return NoteItemWidget(
                note: notes[index],
                dao: dao,
              );
            },
          );
        },
      ),
    );
  }
}