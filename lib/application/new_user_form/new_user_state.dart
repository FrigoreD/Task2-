part of 'new_user_bloc.dart';

class NewUserState extends Equatable {
  final Username username;
  final Surname surname;
  final Name name;
  final Phone phone;
  final FormzStatus status;
  final String? errorMessage;

  const NewUserState(
      {this.username = const Username.pure(),
      this.surname = const Surname.pure(),
      this.name = const Name.pure(),
      this.phone = const Phone.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage});

  @override
  List<Object> get props => [username, surname, name, phone, status];

  NewUserState copyWith(
      {Username? username,
      Surname? surname,
      Name? name,
      Phone? phone,
      FormzStatus? status,
      String? errorMessage}) {
    return NewUserState(
        username: username ?? this.username,
        surname: surname ?? this.surname,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  String toString() {
    return 'User {username: $username, surname: $surname, name: $name, phone: $phone}';
  }

  Map<String, Object> toDocument() {
    return {
      'username': username,
      'surname': surname,
      'name': name,
      'phone': phone
    };
  }

  Map<String, Object> toJson() {
    return {
      'username': username,
      'surname': surname,
      'name': name,
      'phone': phone,
    };
  }
}

class NewUserStateInitial extends NewUserState {}

class NewUserStateAdded extends NewUserState {}

class NewUserStateFetched extends NewUserState {
  final Map data;
  const NewUserStateFetched({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}
