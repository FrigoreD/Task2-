import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/sign_in/view/sign_in_form.dart';
import 'package:task2/infrastructation/repository.dart';

import 'package:task2/application/auth/sign_in_form/sign_in_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => SignInCubit(context.read<AuthRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}







