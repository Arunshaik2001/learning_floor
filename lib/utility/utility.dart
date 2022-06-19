

import 'package:flutter/material.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/entities/note.dart';

class Utility{

  static void openAddNodeDialog(BuildContext context,NotesDao dao, String title, {Note? note}) {

    String noteTitle="";
    String description="";
    if (note != null) {
      noteTitle = note.title;
      description = note.description;
    }

    showDialog<Widget>(
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(title),
        content: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onFieldSubmitted: (value){
                  noteTitle = value;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  hintText: 'Type title of note here',
                ),
              ),
              TextFormField(
                maxLines: 2,
                onFieldSubmitted: (value){
                  description = value;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  hintText: 'Type description here',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Text(
                'Cancel',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text(
                'Save',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (note != null) {
                  note = note?.copyWith(
                      message: noteTitle,
                      description: description);
                }
                await _persistMessage(dao,title:noteTitle,description: description,note: note);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  static Future<void> _persistMessage(NotesDao dao,{String? title,String? description,Note? note}) async {
    if (note != null) {
      await dao.updateNote(note);
      return;
    }

    if(title!.isNotEmpty && description!.isNotEmpty) {
      final newNote = Note(null, title, description);
      await dao.insertNote(newNote);
    }
  }
}