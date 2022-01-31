import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:task2/infrastructation/repository.dart';
import 'package:task2/presentation/app/app.dart';

import 'application/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  final authRepository = AuthRepository();
  await authRepository.user.first;
  BlocOverrides.runZoned(() => runApp(App(authRepository: authRepository)),
      blocObserver: AppBlocObserver());
}
