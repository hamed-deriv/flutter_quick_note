import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: "app_db.sqlite"));

  int get schemaVersion => 1;

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes() => select(notes).watch();

  Future insertNewNote(Note note) => into(notes).insert(note);

  Future deleteNote(Note note) => delete(notes).delete(note);
}
