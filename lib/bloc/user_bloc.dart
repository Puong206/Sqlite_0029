import 'package:database_paml/bloc/user_event.dart';
import 'package:database_paml/bloc/user_state.dart';
import 'package:database_paml/domain/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await repository.getAllUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError('Gagal memuat data'));
      }
    });
  }
}