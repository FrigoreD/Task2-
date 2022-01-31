part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final DataUser user;
  const AppState._({
    required this.status,
    this.user = DataUser.empty,
  });

  const AppState.authenticated(DataUser user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
