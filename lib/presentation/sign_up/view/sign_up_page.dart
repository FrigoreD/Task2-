import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/application/auth/sign_up_form/sign_up_cubit.dart';
import 'package:task2/presentation/sign_up/view/sign_up_form.dart';
import 'package:task2/infrastructation/repository.dart';
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider(
            create: (_) => SignUpCubit(context.read<AuthRepository>()),
            child: const SignUpForm(),
          )),
    );
  }
}
