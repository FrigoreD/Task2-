import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/application/new_user_form/new_user_bloc.dart';
import 'package:task2/infrastructation/database.dart';
import 'package:task2/presentation/user_form/user_form_form.dart';

class UserFormPage extends StatelessWidget {
  const UserFormPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserFormPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'cancel',
            softWrap: false,
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: const Text('UserForm'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider(
            create: (_) => NewUserBloc(context.read<Database>()),
            child: const UserForm(),
          )),
    );
  }
}
