import 'package:flutter/material.dart';

import '../data/note.dart';
import '../providers.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({Key? key, this.id}) : super(key: key);

  static const routeName = '/edit';

  final int? id;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Color memoColor = Note.colorDefault;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final noteId = widget.id;
    if (noteId != null) {
      noteManager().getNote(noteId).then((note) {
        titleController.text = note.title;
        bodyController.text = note.body;
        setState(() {
          memoColor = note.color;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('딘등오의 노트 편집'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: _displayColorSelectionDialog,
            icon: const Icon(Icons.color_lens),
            tooltip: '배경색 선택',
          ),
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(Icons.save),
            tooltip: '저장',
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: memoColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('제목 입력'),
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  controller: titleController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '내용 입력',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: bodyController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus!.unfocus();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('배경색 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('없음'),
                onTap: () => _applyColor(Note.colorDefault),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorRed,
                ),
                title: Text('빨간색'),
                onTap: () => _applyColor(Note.colorRed),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorLime,
                ),
                title: Text('연두색'),
                onTap: () => _applyColor(Note.colorLime),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorBlue,
                ),
                title: Text('파란색'),
                onTap: () => _applyColor(Note.colorBlue),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorOrange,
                ),
                title: Text('주황색'),
                onTap: () => _applyColor(Note.colorOrange),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorYellow,
                ),
                title: Text('노란색'),
                onTap: () => _applyColor(Note.colorYellow),
              ),
            ],
          ),
        );
      },
    );
  }

  void _applyColor(Color newColor) {
    setState(() {
      Navigator.pop(context);
      memoColor = newColor;
    });
  }

  void _saveNote() {
    if (bodyController.text.isNotEmpty) {
      final note = Note(
        bodyController.text,
        title: titleController.text,
        color: memoColor,
      );
      final noteIndex = widget.id;
      if (noteIndex != null) {
        noteManager().updateNote(noteIndex, note);
      } else {
        noteManager().addNote(note);
      }
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('내용을 입력하세요.'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}