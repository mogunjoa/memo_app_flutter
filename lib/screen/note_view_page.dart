import 'package:flutter/material.dart';

import '../data/note.dart';
import '../providers.dart';
import 'note_edit_page.dart';

class NoteViewPage extends StatefulWidget {
  const NoteViewPage({Key? key, required this.id}) : super(key: key);

  static const routeName = '/view';

  final int id;


  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Note>(
        future: noteManager().getNote(widget.id),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('오류가 발생했습니다.'),
              ),
            );
          }
          final note = snapshot.requireData;
          return Scaffold(
            appBar: AppBar(
              title: Text(note.title.isEmpty ? '(제목없음)' : note.title),
              actions: [
                IconButton(
                  onPressed: () {
                    _edit(widget.id);
                  },
                  icon: const Icon(Icons.edit),
                  tooltip: '편집',
                ),
                IconButton(
                  onPressed: () {
                    _confirmDelete(widget.id);
                  },
                  icon: const Icon(Icons.delete),
                  tooltip: '삭제',
                ),
              ],
            ),
            body: SizedBox.expand(
              child: Container(
                color: note.color,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Text(note.body),
                ),
              ),
            ),
          );
        }
    );
  }

  void _edit(int index) {
    Navigator.pushNamed(
      context,
      NoteEditPage.routeName,
      arguments: index,
    ).then((_) {
      setState(() {});
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('노트 삭제'),
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
                noteManager().deleteNote(index);
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