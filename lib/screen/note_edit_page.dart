import 'package:flutter/material.dart';
import 'package:memo_app/providers.dart';

import '../data/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({Key? key, int? index}) : super(key: key);
  static const routeName = '/edit';

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Color memoColor = Note.colorDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('노트 편집'),
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
                  decoration: InputDecoration(
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
          title: Text('배경색 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('없음'),
                onTap: () => _applyColor(Note.colorDefault),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Note.colorRed,
                ),
                title: Text('빨간색'),
                onTap: () => _applyColor(Note.colorRed),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Note.colorLime,
                ),
                title: Text('연두색'),
                onTap: () => _applyColor(Note.colorLime),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Note.colorBlue,
                ),
                title: Text('파란색'),
                onTap: () => _applyColor(Note.colorBlue),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Note.colorOrange,
                ),
                title: Text('주황색'),
                onTap: () => _applyColor(Note.colorOrange),
              ),
              ListTile(
                leading: CircleAvatar(
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
      noteManager().addNote(Note(
        bodyController.text,
        title: titleController.text,
        color: memoColor,
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('내용을 입력하세요.'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
