import 'package:formz/formz.dart';

enum SurnameValidationError { invalid }

class Surname extends FormzInput<String, SurnameValidationError> {
  const Surname.pure() : super.pure('');

  const Surname.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z]*$');

  @override
  SurnameValidationError? validator(String? value) {
    return _usernameRegExp.hasMatch(value ?? '')
        ? null
        : SurnameValidationError.invalid;
  }
}
