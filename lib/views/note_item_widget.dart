import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:learning_floor/constants/constants.dart';
import 'package:learning_floor/dao/notes_dao.dart';
import 'package:learning_floor/entities/note.dart';
import 'package:learning_floor/utility/utility.dart';
import 'package:provider/provider.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class NoteItemWidget extends StatefulWidget {
  final Note note;
  final NotesDao dao;

  const NoteItemWidget({
    Key? key,
    required this.note,
    required this.dao,
  }) : super(key: key);

  @override
  State<NoteItemWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget> {
  late final FirebaseRemoteConfig remoteConfig;

  @override
  void initState() {
    remoteConfig = context.read<FirebaseRemoteConfig>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Dismissible(
        onDismissed: (direction) async {
          await widget.dao.deleteNote(widget.note);
        },
        direction: remoteConfig.getBool(Constants.can_delete_note)
            ? DismissDirection.horizontal
            : DismissDirection.none,
        key: Key(widget.note.hashCode.toString()),
        child: GestureDetector(
          onTap: () {
            Utility.openAddNodeDialog(context, widget.dao, "Edit Note",
                note: widget.note);
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(int.parse(
                "0xff${remoteConfig.getString(Constants.note_tile_color)}")),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title,
                    style: TextStyle(
                        color: Color(int.parse(
                            "0xff${remoteConfig.getString(Constants.note_title_color)}")),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (remoteConfig.getBool(Constants.show_description))
                    Text(
                      widget.note.description,
                      style: TextStyle(
                          color: Color(int.parse(
                              "0xff${remoteConfig.getString(Constants.note_description_color)}")),
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
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
