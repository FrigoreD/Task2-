import 'dart:convert';

import 'package:equatable/equatable.dart';

class DataUser extends Equatable {
  final String? uid;
  final String? email;
  final String? password;

  const DataUser({required this.uid, this.email, this.password});

  static const empty = DataUser(uid: '');

  bool get isEmpty => this == DataUser.empty;
  bool get isNotEmpty => this != DataUser.empty;

  DataUser copyWith({
    String? uid,
    String? email,
    String? password,
  }) {
    return DataUser(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password);
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'password': password,
      };

  DataUser.fromMap(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        password = json['password'];

  String toJson() => json.encode(toMap());

  factory DataUser.fromJson(String source) =>
      DataUser.fromMap(json.encode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataUser(uid: $uid, email: $email, password: $password)';
  }

  @override
  List<Object?> get props => [uid, email, password];
}
