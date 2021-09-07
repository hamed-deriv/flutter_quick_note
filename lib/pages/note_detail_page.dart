import 'package:flutter/material.dart';
import 'package:flutter_quick_note/database/app_database.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({required this.note, Key? key}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (note.imageUrl != '')
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image.network(note.imageUrl!),
              ),
            SizedBox(height: 16),
            Text(
              '${note.title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              note.description!,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
