part of 'new_user_bloc.dart';

abstract class NewUserEvent extends Equatable {
  const NewUserEvent();

  @override
  List<Object> get props => [];
}

class AddNewUserEvent extends NewUserEvent {}

class GetNewUserEvent extends NewUserEvent {}

class DeleteNewUserEvent extends NewUserEvent {
  const DeleteNewUserEvent(this.username);
  final String username;
}
