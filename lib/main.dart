import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tarek_test_app/src/core/utils/bloc_observer.dart';
import 'package:tarek_test_app/src/core/utils/dio_helper.dart';

import 'src/config/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(MyApp());
}
