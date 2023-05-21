import 'package:flutter/material.dart';
import 'package:memo_app/screen/note_edit_page.dart';
import 'package:memo_app/screen/note_list_page.dart';
import 'package:memo_app/screen/note_view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: NoteListPage.routeName,
      routes: {
        NoteListPage.routeName: (context) => const NoteListPage(),
        NoteEditPage.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final id = args != null  ? args  as int : null;
          return NoteEditPage(id: id,);
        },
        NoteViewPage.routeName: (context) {
          final id = ModalRoute.of(context)!.settings.arguments as int;
          return NoteViewPage(id: id);
        },
      },
    );
  }
}