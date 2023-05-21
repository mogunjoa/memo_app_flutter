import 'package:flutter/material.dart';

import '../data/note.dart';
import '../providers.dart';
import 'note_edit_page.dart';
import 'note_view_page.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('딘등오의 메모'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Note>>(
          future: noteManager().listNotes(),
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
            final notes = snapshot.requireData;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) => _buildCard(notes[index]),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '새 노트',
        onPressed: () {
          Navigator.pushNamed(context, NoteEditPage.routeName).then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }



  Widget _buildCard(Note note) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NoteViewPage.routeName, arguments: note.id)
            .then((_) {
          setState(() {});
        });
      },
      child: Card(
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
      ),
    );
  }
}