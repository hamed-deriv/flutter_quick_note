abstract class NotesState {}

class InitialState extends NotesState {}

class SearchingState extends NotesState {}

class FetchedState extends NotesState {
  FetchedState(this.result);

  final List<dynamic>? result;
}

class ErrorState extends NotesState {
  ErrorState(this.message);

  final String message;
}
