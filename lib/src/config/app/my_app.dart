import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarek_test_app/src/presentations/cubits/database_cubit/database_cubit.dart';

import '../../presentations/views/employee_view.dart';

class MyApp extends StatefulWidget {
  // named Constructor
  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); // Singleton or Single Instance.

  factory MyApp() => _instance; //factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DatabaseCubit()..createDataBase()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EmployeeView(),
      ),
    );
  }
}
