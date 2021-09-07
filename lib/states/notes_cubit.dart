import 'package:bloc/bloc.dart';

import 'package:flutter_quick_note/states/notes_state.dart';
import 'package:flutter_quick_note/repositories/word_repository.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this.repository) : super(InitialState());

  final WordRepository repository;

  Future<void> search(String query) async {
    try {
      emit(SearchingState());

      emit(FetchedState(null));
    } on Exception catch (e) {
      emit(ErrorState('$e'));
    }
  }
}
