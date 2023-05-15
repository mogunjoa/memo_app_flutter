import 'package:flutter/material.dart';
import 'package:memo_app/providers.dart';
import '../data/note.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('딘등오의 메모장'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        children: _buildCards(),
      ),
    );
  }
}

List<Widget> _buildCards() {
  return noteManager().listNotes().map((note) => _buildCard(note)).toList();
}

Widget _buildCard(Note note) {
  return Card(
    color: note.color,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title.isEmpty ? '(제목없음)' : note.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Text(
              note.body,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    ),
  );
}
