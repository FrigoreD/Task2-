import 'package:flutter/material.dart';
import 'package:task2/application/app/app_bloc.dart';
import 'package:task2/infrastructation/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/routes/routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:task2/presentation/task_2_theme.dart';


class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authRepository: _authRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}
class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TaskTheme.light(),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}