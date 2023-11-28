import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/tab_container_page/tab_container_page.dart';
import 'app_bloc_observer.dart';


void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const HrmsApp());
}

class HrmsApp extends StatelessWidget {
  const HrmsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white12,
        fontFamily: 'Source Sand Pro',
      ),
      home: const TabContainerPage(),
    );
  }
}

