

import 'package:flutter/material.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/entities/note.dart';
import 'package:learning_floor/utility/utility.dart';

class NoteItemWidget extends StatelessWidget {
  final Note note;
  final NotesDao dao;

  const NoteItemWidget({
    Key? key,
    required this.note,
    required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Dismissible(
        onDismissed: (direction) async {
          await dao.deleteNote(note);
        },
        direction: DismissDirection.horizontal,
        key: Key(note.hashCode.toString()),
        child: GestureDetector(
          onTap: () {
            Utility.openAddNodeDialog(context,dao, "Edit Note", note: note);
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.blueAccent,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(color: Colors.white,
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    note.description,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}