import 'package:flutter/material.dart';
import 'package:task2/application/app/app_bloc.dart';
import 'package:task2/presentation/home/home_page.dart';
import 'package:task2/presentation/sign_in/view/sign_in_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}