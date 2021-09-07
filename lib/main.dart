import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quick_note/database/app_database.dart';

import 'package:flutter_quick_note/pages/home_page.dart';
import 'package:flutter_quick_note/states/notes_cubit.dart';
import 'package:flutter_quick_note/repositories/word_repository.dart';

late final AppDatabase appDatabase;

void main() {
  appDatabase = AppDatabase();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Quick Learn',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: BlocProvider(
          create: (context) => NotesCubit(WordRepository()),
          child: HomePage(),
        ),
      );
}
