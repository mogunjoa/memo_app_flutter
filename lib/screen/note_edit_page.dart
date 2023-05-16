import 'package:flutter/material.dart';
import 'package:memo_app/providers.dart';

import '../data/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({Key? key, this.index}) : super(key: key);
  static const routeName = "/edit";
  final int? index;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  Color memoColor = Note.colorDefault;

  @override
  void initState() {
    super.initState();

    final note = Note(
      contentController.text,
      title: titleController.text,
      color: memoColor,
    );

    final noteIndex = widget.index;
    if(noteIndex != null) {
      noteManager().updateNote(noteIndex, note);
    } else {
      noteManager().addNote(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: memoColor,
        title: Text("딘등오의 메모작성"),
        actions: [
          IconButton(
              tooltip: '배경색 선택',
              onPressed: () => {_displayColorSelectionDialog()},
              icon: const Icon(Icons.color_lens)),
          IconButton(onPressed: () => {
            _saveNote()
          }, icon: const Icon(Icons.save))
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
                  controller: titleController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      label: Text(
                        '제목 입력',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 5,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: contentController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: '내용입력'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus?.unfocus();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('배경색 선택'),
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
    if (contentController.text.isNotEmpty) {
      noteManager().addNote(Note(contentController.text,
          title: titleController.text, color: memoColor));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('내용을 입력하세요.'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
