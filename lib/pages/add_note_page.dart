import 'package:flutter/material.dart';

import 'package:flutter_quick_note/database/app_database.dart';
import 'package:flutter_quick_note/main.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleEditTextController =
        TextEditingController();
    final TextEditingController descriptionEditTextController =
        TextEditingController();
    final TextEditingController imageUrlEditTextController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Add Note',
          style: TextStyle(color: Colors.deepOrangeAccent),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                appDatabase.insertNewNote(
                  Note(
                    title: titleEditTextController.text,
                    description: descriptionEditTextController.text,
                    imageUrl: imageUrlEditTextController.text,
                  ),
                );

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleEditTextController,
                cursorColor: Colors.orangeAccent,
                decoration: InputDecoration(
                  hintText: 'Title',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintStyle: TextStyle(color: Colors.black26),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: descriptionEditTextController,
                cursorColor: Colors.orangeAccent,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Description',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintStyle: TextStyle(color: Colors.black26),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: imageUrlEditTextController,
                cursorColor: Colors.orangeAccent,
                decoration: InputDecoration(
                  hintText: 'Image Url',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintStyle: TextStyle(color: Colors.black26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
