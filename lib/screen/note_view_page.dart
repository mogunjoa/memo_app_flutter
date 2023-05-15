import 'package:flutter/material.dart';
import 'package:memo_app/data/note_manager.dart';
import 'package:memo_app/screen/note_edit_page.dart';

class NoteViewPage extends StatefulWidget {
  const NoteViewPage({Key? key, required this.index}) : super(key: key);
  static const routeName = "/view";
  final int index;

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {

  @override
  Widget build(BuildContext context) {
    final note = NoteManager().getNote(widget.index);
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title.isEmpty? '(제목없음)': note.title),
      ),
    );
  }

  void _edit(int index) {
    Navigator.pushNamed(context, NoteEditPage.routeName, arguments: index).then(
        (_) {
          setState(() {

          });
        }
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('노트 삭제123'),
          content: Text('노트를 삭제 할까요?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                // noteManager().deleteNote(index);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }
}
