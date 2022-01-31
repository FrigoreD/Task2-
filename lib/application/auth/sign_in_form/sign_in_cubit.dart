import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:task2/domain/email.dart';
import 'package:task2/domain/password.dart';
import 'package:task2/infrastructation/failure/sign_in_failure.dart';
import 'package:task2/infrastructation/repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepository) : super(const SignInState());
  final AuthRepository _authRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value){
    final password = Password.dirty(value);
    emit(state.copyWith(password: password,status: Formz.validate([state.email, password])));
  }

   Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
