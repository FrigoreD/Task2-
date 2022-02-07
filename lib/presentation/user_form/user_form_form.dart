import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task2/application/new_user_form/new_user_bloc.dart';
import 'package:task2/presentation/task_2_theme.dart';


class UserForm extends StatelessWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewUserBloc, NewUserState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'something went wrong')));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _UsernameInput(),
                _SurnameInput(),
                _NameInput(),
                _PhoneInput(),
                _SaveForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
       BlocBuilder<NewUserBloc, NewUserState>(
        buildWhen: (previous , current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('UserForm_usernameinput_textField'),
            onChanged: (username) =>
                context.read<NewUserBloc>().usernameChanged(username),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: 'username',
                helperText: '',
                errorText: state.username.invalid ? 'invalid username' : null),
          );
        },
      );
    
  }
}

class _SurnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewUserBloc, NewUserState>(
      buildWhen: (previous, current) => previous.surname != current.surname,
      builder: (context, state) {
        return TextField(
          key: const Key('UserForm_surnameinput_textField'),
          onChanged: (surname) =>
              context.read<NewUserBloc>().surnameChanged(surname),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              hintText: 'surname',
              helperText: '',
              errorText: state.surname.invalid ? 'invalid surname' : null),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewUserBloc, NewUserState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('UserForm_nameinput_textField'),
          onChanged: (name) => context.read<NewUserBloc>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              hintText: 'name',
              helperText: '',
              errorText: state.name.invalid ? 'invalid name' : null),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewUserBloc, NewUserState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextField(
          key: const Key('UserForm_phoneinput_textField'),
          onChanged: (phone) =>
              context.read<NewUserBloc>().phoneChanged(phone),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              hintText: 'phone',
              helperText: '',
              errorText: state.phone.invalid ? 'invalid phone' : null),
        );
      },
    );
  }
}

class _SaveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewUserBloc, NewUserState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('NewUserForm_SaveForm'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: kPrimaryGreen,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<NewUserBloc>().add((AddNewUserEvent()))
                    : null,
                child: const Text('Save user'),
              );
      },
    );
  }
}
