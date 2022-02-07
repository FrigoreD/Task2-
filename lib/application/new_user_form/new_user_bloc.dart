// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';
import 'package:task2/domain/name.dart';
import 'package:task2/domain/phone.dart';
import 'package:task2/domain/surname.dart';
import 'package:task2/domain/username.dart';
import 'package:task2/infrastructation/database.dart';
import 'package:equatable/equatable.dart';
import 'package:task2/infrastructation/failure/database_faliure.dart';

part 'new_user_state.dart';
part 'new_user_event.dart';

class NewUserBloc extends Bloc<NewUserEvent, NewUserState> {
  NewUserBloc(this._database) : super(NewUserStateInitial()) {
    on<AddNewUserEvent>(_onAddNewUserEvent);
    on<DeleteNewUserEvent>(_onDeleteNewUserEvent);
  }

  final Database _database;

  void _onAddNewUserEvent(
      AddNewUserEvent event, Emitter<NewUserState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _database.addNewUser(
          username: state.username.value,
          surname: state.surname.value,
          name: state.name.value,
          phone: state.phone.value);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          username: state.username,
          surname: state.surname,
          name: state.name,
          phone: state.phone));
    } on DatabaseFaliure catch (e) {
      emit(state.copyWith(
          errorMessage: e.message, status: FormzStatus.submissionFailure));
    }
  }

  void _onDeleteNewUserEvent(
    DeleteNewUserEvent event,
    Emitter<NewUserState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _database.deleteUser(state.username.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on DatabaseFaliure catch (e) {
      emit(state.copyWith(
          errorMessage: e.message, status: FormzStatus.submissionFailure));
    }
  }


  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
        username: username,
        status: Formz.validate([
          username,
          state.surname,
          state.name,
          state.phone,
        ])));
  }

  void surnameChanged(String value) {
    final surname = Surname.dirty(value);
    emit(state.copyWith(
        surname: surname,
        status: Formz.validate([
          state.username,
          surname,
          state.name,
          state.phone,
        ])));
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
        name: name,
        status: Formz.validate([
          state.username,
          state.surname,
          name,
          state.phone,
        ])));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
        phone: phone,
        status: Formz.validate([
          state.username,
          state.surname,
          state.name,
          phone,
        ])));
  }

  void userStateChanged(
      {required String username,
      required String surname,
      required String name,
      required String phone}) {
    usernameChanged(username);
    surnameChanged(surname);
    nameChanged(name);
    phoneChanged(phone);
  }



  

  Stream<QuerySnapshot<Object?>>? getUsers() {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final snap = _database.getUsers();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return snap;
    } on DatabaseFaliure catch (e) {
      emit(state.copyWith(
          errorMessage: e.message, status: FormzStatus.submissionFailure));
      return null;
    }
  }
}
