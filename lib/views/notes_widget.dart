



import 'package:flutter/material.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/utility/utility.dart';
import 'package:learning_floor/views/notes_list_view.dart';

class NotesWidget extends StatefulWidget {
  final String title;
  final NotesDao dao;

  const NotesWidget({
    Key? key,
    required this.title,
    required this.dao,
  }) : super(key: key);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title),actions: [
          IconButton(tooltip:"Delete All",onPressed: () async{
            await widget.dao.deleteAllNotes();
            setState(() {});
          }, icon: const Icon(Icons.delete_forever))
        ],),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              NotesListView(dao: widget.dao),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Utility.openAddNodeDialog(context,widget.dao, 'Add Note'),
          tooltip: 'Add Note',
          child: const Text(
            '+',
            style: TextStyle(fontSize: 50),
          ),
        ));
  }
}