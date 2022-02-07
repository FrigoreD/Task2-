import 'package:flutter/material.dart';
import 'package:task2/application/app/app_bloc.dart';
import 'package:task2/application/new_user_form/new_user_bloc.dart';
import 'package:task2/infrastructation/database.dart';
import 'package:task2/infrastructation/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/presentation/routes/routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:task2/presentation/task_2_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthRepository authRepository,
    required Database firestore,
  })  : _authRepository = authRepository,
        _firestore = firestore,
        super(key: key);

  final AuthRepository _authRepository;
  final Database _firestore;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _firestore)
      ],
      child: BlocProvider<AppBloc>(
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
