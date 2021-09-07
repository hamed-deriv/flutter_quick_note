import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_quick_note/database/app_database.dart';
import 'package:flutter_quick_note/pages/add_note_page.dart';
import 'package:flutter_quick_note/pages/note_detail_page.dart';
import 'package:flutter_quick_note/states/notes_cubit.dart';
import 'package:flutter_quick_note/states/notes_state.dart';
import 'package:flutter_quick_note/main.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Quick Note',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is FetchedState && state.result != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is InitialState) {
            return _buildInputForm(context);
          } else if (state is SearchingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return _buildErrorWidget(state.message);
          }

          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddNotePage(),
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm(BuildContext context) {
    final TextEditingController editTextController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            controller: editTextController,
            cursorColor: Colors.orangeAccent,
            decoration: InputDecoration(
              hintText: 'Search',
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
              prefixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.orangeAccent),
                onPressed: () {},
              ),
              hintStyle: TextStyle(color: Colors.black26),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: appDatabase.watchAllNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.only(bottom: 96),
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(
                        Icons.now_widgets,
                        color: Colors.deepOrangeAccent,
                      ),
                      title: Text(
                        '${snapshot.data![index].title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${snapshot.data![index].description}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () =>
                            appDatabase.deleteNote(snapshot.data![index]),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteDetailPage(note: snapshot.data![index]),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
