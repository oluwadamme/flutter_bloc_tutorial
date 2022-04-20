import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/src/apis/login_api.dart';
import 'package:flutter_bloc_tutorial/src/apis/notes_api.dart';
import 'package:flutter_bloc_tutorial/src/bloc/actions.dart';
import 'package:flutter_bloc_tutorial/src/bloc/app_state.dart';
import 'package:flutter_bloc_tutorial/src/models/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApiProtocol;
  final NotesApiProtocol notesApiProtocol;

  AppBloc({
    required this.loginApiProtocol,
    required this.notesApiProtocol,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // loading the state
      emit(
        const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );
      // log user in
      final loginHandle = await loginApiProtocol.login(
        email: event.email,
        password: event.password,
      );
      emit(
        AppState(
          isLoading: true,
          loginErrors: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>((event, emit) async {
      // loading starts and the pervious state of our loginHandle is included
      emit(
        AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
      // get the login handle

      final loginHandle = state.loginHandle;

      if (loginHandle == const LoginHandle.foobar()) {
        // emit invalid login handle state, cannot fetch notes
        emit(
          AppState(
            isLoading: false,
            loginErrors: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      }
      // valid login handle and fetch notes
      final notes = await notesApiProtocol.getNotes(loginHandle: loginHandle!);
      emit(
        AppState(
          isLoading: false,
          loginErrors: null,
          loginHandle: loginHandle,
          fetchedNotes: notes,
        ),
      );
    });
  }
}
